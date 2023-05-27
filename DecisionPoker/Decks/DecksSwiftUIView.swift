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
    @Binding var path: NavigationPath
    @State private var isPresented = false
    @State var gameResult: [Card] = []
    @State var selectedDeck = Deck()

    init(path: Binding<NavigationPath>) {
        self._path = path

        UIStepper.appearance().setIncrementImage(UIImage(systemName: "plus"), for: .normal)
        UIStepper.appearance().setDecrementImage(UIImage(systemName: "minus"), for: .normal)
        UIStepper.appearance().tintColor = theme.currentBackgroundColorUI
    }

    @Environment(\.managedObjectContext) var managedObjectContext

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
                            DeckCell(deck: deck, path: $path, gameResult: $gameResult, selectedDeck: $selectedDeck)
                        }
                    }
                    .onDelete(perform: deleteDeck)
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 8)
                            .background(.clear)
                            .foregroundColor(theme.currentBackgroundColor)
                            .padding(
                                EdgeInsets(
                                    top: 5,
                                    leading: 10,
                                    bottom: 5,
                                    trailing: 10
                                )
                            )
                    )
                    .listRowSeparator(.hidden)
                }
            }
            .toolbarBackground(
                theme.currentBackgroundColor,
                for: .tabBar, .navigationBar)
            .toolbarBackground(.visible, for: .tabBar, .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .scrollContentBackground(.hidden)
            .toolbar {
                ToolbarItem(placement: .principal) {
                            VStack {
                                Text("Decision Poker")
                                    .font(Font(UIFont(name: theme.currentFont, size: 24)!))
                                  .foregroundColor(Color.white)
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
                    .imageScale(.medium)
            }))
        }
        .navigationDestination(for: String.self) { _ in
            DealResultSwiftUIView(selectedDeck: $selectedDeck, results: $gameResult, path: self.$path)
        }
        .background(BackgroundCardView().scaledToFit())
    }
    
    private func deleteDeck(at offsets: IndexSet) {
        offsets.forEach { index in
            let deck = self.decks[index]
            self.managedObjectContext.delete(deck)
        }
        
        do {
            try self.managedObjectContext.save()
        } catch {
            print("error when deleting deck: \(error)")
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

// struct DecksSwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        //DecksSwiftUIView().environmentObject(AppState())
//    }
// }
