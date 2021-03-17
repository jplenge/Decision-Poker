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
        
        UITableView.appearance().allowsSelection = true
        UITableViewCell.appearance().selectionStyle = .none
        
        // syle navigation bar
        
        let navigationbarAppearance = UINavigationBarAppearance()
        navigationbarAppearance.configureWithOpaqueBackground()
        
        navigationbarAppearance.shadowColor = .clear
        navigationbarAppearance.backgroundColor = Theme.currentBackgroundColorUI
        //navigationbarAppearance.largeTitleTextAttributes = [.font: UIFont(name: Theme.currentFont, size: 28)!, .foregroundColor: Theme.currentTextColorUI]
        navigationbarAppearance.titleTextAttributes =  [.font: UIFont(name: Theme.currentFont, size: 20)!, .foregroundColor: Theme.currentTextColorUI ?? UIColor.white]
               
        let buttonAppearance = UIBarButtonItemAppearance(style: .plain)
        buttonAppearance.normal.titleTextAttributes = [.font: UIFont(name: Theme.currentFont, size: 20)!, .foregroundColor: Theme.currentTextColorUI ?? UIColor.white]
        navigationbarAppearance.buttonAppearance = buttonAppearance

        UINavigationBar.appearance().standardAppearance = navigationbarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationbarAppearance
        
        UIStepper.appearance().setIncrementImage(UIImage(systemName: "plus"), for: .normal)
        UIStepper.appearance().setDecrementImage(UIImage(systemName: "minus"), for: .normal)
        UIStepper.appearance().tintColor = Theme.currentBackgroundColorUI

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
                    .listRowBackground(Theme.currentBackgroundColor)
                    
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
            })
            .background(Theme.currentBackgroundColor)
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
