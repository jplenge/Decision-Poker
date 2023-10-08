//
//  DecksSwiftUIView.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 24.06.20.
//  Copyright © 2020 Jodi Szarko. All rights reserved.
//

import SwiftUI
import CoreData

struct DecksSwiftUIView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Binding var path: NavigationPath
    @State private var isPresented = false
    @StateObject private var viewModel = ViewModel()
    @AppStorage("SelectedColor") private var selectedColor: Int = 0
    
    init(path: Binding<NavigationPath>) {
        self._path = path
        UIStepper.appearance().setIncrementImage(UIImage(systemName: "plus"), for: .normal)
        UIStepper.appearance().setDecrementImage(UIImage(systemName: "minus"), for: .normal)
    }

    // fetch all decks from core data
    @FetchRequest(entity: Deck.entity(), sortDescriptors: [NSSortDescriptor(
        key: "decksTablePosition",
        ascending: true,
        selector: #selector(NSNumber.compare(_:))
    )]) var decks: FetchedResults<Deck>
    
    var body: some View {
        VStack(alignment: .leading) {
            List {
                if !decks.isEmpty {
                    ForEach(decks, id:\.deckName) { deck in
                        NavigationLink(value: deck) {
                            DeckCell(deck: deck, path: $path, viewModel: viewModel)
                        }
                    }
                    .onDelete(perform: deleteDeck)
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 20)
                            .background(.clear)
                            .foregroundColor(theme.colors[selectedColor])
                            .padding(
                                EdgeInsets(
                                    top: 5,
                                    leading: 0,
                                    bottom: 5,
                                    trailing: 0
                                )
                            )
                    )
                    .listRowSeparator(.hidden)
                }
            }
            .scrollIndicators(.hidden)
            .toolbarBackground(.visible, for: .tabBar, .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .scrollContentBackground(.hidden)
            .toolbar {
                ToolbarItem(placement: .principal) {
                            VStack {
                                Text("deck.tab.title", comment: "tab item title")
                                    .fontWeight(.bold)
                                    .fontDesign(.rounded)
                                    .foregroundColor(theme.colors[selectedColor])
                            }
                        }
                    }
            .navigationDestination(for: Deck.self) { deck in
                CardsSwiftUIView(deck: deck)
            }
            .sheet(isPresented: self.$isPresented) {
                AddDeckView {newDeckName, newDeckComment in
                    self.createDeck(newDeckName: newDeckName, newDeckComment: newDeckComment)
                    self.isPresented = false
                }
            }
            .onAppear(perform: {
                self.isPresented = false
            })
            .navigationBarItems(trailing: Button(action: {
                do {
                    try managedObjectContext.save()
                } catch {
                    print(error)
                }
                self.isPresented.toggle()
            }, label: {
                Image(systemName: "plus")
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .imageScale(.medium)
            }))
        }
        .navigationDestination(for: String.self) { _ in
            DealResultSwiftUIView(viewModel: viewModel, path: self.$path)
        }
        .background(BackgroundCardView().scaledToFit())
        .overlay {
            if decks.isEmpty {
                BackgroundCardView().scaledToFit()
            }
        }
    }
    
    private func deleteDeck(at offsets: IndexSet) {
        offsets.forEach { index in
            let deck = self.decks[index]
            self.managedObjectContext.delete(deck)
        }
        
        do {
            try self.managedObjectContext.save()
        } catch {
            print("Error when deleting deck: \(error)")
        }
    }
    
    private func createDeck(newDeckName: String, newDeckComment: String) {
        let newDeck = Deck(context: self.managedObjectContext)
        newDeck.deckName = newDeckName
        newDeck.deckComment = newDeckComment
        newDeck.id = UUID()
        newDeck.decksTablePosition = 99
        newDeck.numberOfCardsToPick = 0
        
        do {
            try self.managedObjectContext.save()
        } catch {
            print(error)
        }
    }
}
