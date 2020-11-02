//
//  CardsSwiftUIView.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 26.06.20.
//  Copyright © 2020 Jodi Szarko. All rights reserved.
//

import SwiftUI

struct CardsSwiftUIView: View {
    @ObservedObject var deck: Deck
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var isPresented: Bool = false
    @State var isShowingDeckComment: Bool = false
    @State var editableText: String = ""
    @State var editableTextField: String = ""
    
    
    var body: some View {
        
        List {
            VStack {
                HStack {
                    
                    Spacer()
                    
                    TextField(deck.wrappedDeckName, text: $editableTextField, onCommit: saveDeckTitle)
                        .multilineTextAlignment(.center)
                        .scaledFont(name: Theme.currentFont, size: 28)
                        .padding()
                        .foregroundColor(Theme.currentTextColor)
                        .onAppear(perform: {
                            editableTextField = deck.wrappedDeckName
                        })
                    
                    Button(action: {
                        self.isShowingDeckComment.toggle()
                    }) {
                        Image(systemName: "info.circle")
                            .frame(width: 22, height: 22)
                            .foregroundColor(Theme.currentButtonBackgroundColor)
                            .padding()
                    }.buttonStyle(BorderlessButtonStyle())  // workaround so that button can be tapped
                    
                    Spacer()
                    
                }
                
                
                if isShowingDeckComment {
                    TextView(text: $editableText) {
                        $0.isEditable = true
                        $0.backgroundColor = Theme.currentBackgroundColorUI
                        $0.font = UIFont(name: Theme.currentFont, size: 13)
                        $0.textColor = Theme.currentTextColorUI
                    }
                    .frame(height: 150)
                    .onAppear(){
                        self.editableText = deck.wrappedDeckComment
                    }
                    .onDisappear(perform: {
                        deck.deckComment = self.editableText
                    })
                }
                
                Spacer()
            }
            .listRowBackground(Theme.currentBackgroundColor)
            
            
            ForEach(deck.childCardsArray, id: \.id) { card in
                CardCell(card: card)
                
            }.onDelete(perform: deleteCard)
            .listRowBackground(Theme.currentBackgroundColor)
            
        }
        .sheet(isPresented: $isPresented) {
            AddCardView {newCardName, newCardComment in
                self.addCard(newCardName: newCardName, newCardComment: newCardComment)
                self.isPresented = false
            }
        }
        .navigationBarTitle("Deck Details", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            self.isPresented.toggle()
        }, label: {
            Image(systemName: "plus")
                .imageScale(.large)
        }))
        .onAppear(perform: {
            UITableView.appearance().backgroundColor = .clear // tableview background
            UITableViewCell.appearance().backgroundColor = .clear // cell background
        })
        .background(Theme.currentBackgroundColor)
        
    }
    
    
    func deleteCard(at offsets: IndexSet) {
        offsets.forEach { index in
            let card = self.deck.childCardsArray[index]
            
            self.managedObjectContext.delete(card)
            
            //saveContext()
            
            do {
                try managedObjectContext.save()
            } catch {
                print(error)
            }
        }
    }
    
    
    
    func addCard(newCardName: String, newCardComment: String) {
        
        let newCard = Card(context: managedObjectContext)
        
        newCard.cardName = newCardName
        newCard.cardComment = newCardComment
        newCard.cardIncluded = true
        newCard.id = UUID()
        newCard.cardsTablePosition = 99
        
        deck.addToChildCards(newCard)
        
        do {
            try self.managedObjectContext.save()
        } catch {
            print(error)
        }
    }
    
    func saveDeckTitle() {
        deck.deckName = editableTextField
    }
    
    
}





struct CardsSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
