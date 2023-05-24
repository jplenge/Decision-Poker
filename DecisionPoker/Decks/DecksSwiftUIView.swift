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
    
    init(path: Binding<NavigationPath>) {
        self._path = path
        
        UITableView.appearance().backgroundColor = .clear
        UITableView.appearance().allowsSelection = true
        UITableViewCell.appearance().selectionStyle = .none
        
        // let navigationbarAppearance = UINavigationBarAppearance()
        // navigationbarAppearance.configureWithOpaqueBackground()
       // navigationbarAppearance.shadowColor = .clear
        // navigationbarAppearance.backgroundColor = theme.currentBackgroundColorUI
        // navigationbarAppearance.titleTextAttributes =  [.font: UIFont(name: theme.currentFont, size: 24)!, .foregroundColor: theme.currentTextColorUI ?? UIColor.white]
        
        let buttonAppearance = UIBarButtonItemAppearance(style: .plain)
        buttonAppearance.normal.titleTextAttributes = [.font: UIFont(name: theme.currentFont, size: 24)!, .foregroundColor: theme.currentTextColorUI ?? UIColor.white]
        // navigationbarAppearance.buttonAppearance = buttonAppearance
        
        // UINavigationBar.appearance().standardAppearance = navigationbarAppearance
        // UINavigationBar.appearance().scrollEdgeAppearance = navigationbarAppearance
        
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
    
    @State var isPresented = false
    
    var body: some View {
            VStack(alignment: .leading) {
                List {
                    if !decks.isEmpty {
                        ForEach(decks, id:\.deckName) { deck in
                            NavigationLink(value: deck) {
                                DeckCell(deck: deck, path: $path)
                            }
                        }
                        .onDelete(perform: deleteDeck)
                        .listRowBackground(theme.currentBackgroundColor)
                    }
                }
                .overlay(Group {
                    if decks.isEmpty {
                        ZStack {
                            theme.currentBackgroundColor.ignoresSafeArea()
                        }
                    }
                })
                .background(theme.currentBackgroundColor)
                .scrollContentBackground(.hidden)
                .sheet(isPresented: $isPresented) {
                    AddDeckView {newDeckName, newDeckComment in
                        self.createDeck(newDeckName: newDeckName, newDeckComment: newDeckComment)
                        self.isPresented = false
                    }
                }
                .navigationTitle("Decision Poker")
                .navigationBarTitleDisplayMode(.inline)
                .navigationDestination(for: Deck.self) { deck in
                    CardsSwiftUIView(deck: deck)
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
                        .imageScale(.large)
                }))
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
