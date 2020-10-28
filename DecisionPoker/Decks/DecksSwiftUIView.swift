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
    
    init() {
        
        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: currentFont, size: 20)!, .foregroundColor: backgroundcolorGreenUI]
        UINavigationBar.appearance().tintColor = backgroundcolorGreenUI
        
        UITableView.appearance().allowsSelection = true
        UITableViewCell.appearance().selectionStyle = .none
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
        
        VStack(alignment: .center) {
            List {
                if !decks.isEmpty {
                    ForEach (decks, id:\.deckName) { deck in
                        NavigationLink(destination: CardsSwiftUIView(deck: deck)) {
                            DeckCell(deck: deck)
                        }
                    }.onDelete(perform: deleteDeck)
                    .listRowBackground(backgroundcolorGreen)
                    
                }
            }
            .sheet(isPresented: $isPresented) {
                AddDeckView {newDeckName, newDeckComment in
                    self.createDeck(newDeckName: newDeckName, newDeckComment: newDeckComment)
                    self.isPresented = false
                }
            }
            .navigationBarTitle("Decks", displayMode: .inline)
            .navigationBarHidden(false)  //
            .onAppear(perform: {
                UITableView.appearance().backgroundColor = .clear // tableview background
                UITableViewCell.appearance().backgroundColor = .clear // cell background
                self.isPresented = false
                print(decks)
            })
            .background(backgroundcolorGreen)
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
    
    
    
    // function: delete deck from core data
    func deleteDeck(at offsets: IndexSet) {
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
    
    func createDeck(newDeckName: String, newDeckComment: String) {
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




struct DecksSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
