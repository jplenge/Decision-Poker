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
                        .scaledFont(name: theme.currentFont, size: 28)
                        .padding()
                        .foregroundColor(theme.currentTextColor)
                        .onAppear(perform: {
                            editableTextField = deck.wrappedDeckName
                        })
                    
                    Button(action: {
                        self.isShowingDeckComment.toggle()
                    }, label: {
                        Image(systemName: "info.circle")
                            .frame(width: 22, height: 22)
                            .foregroundColor(theme.currentButtonBackgroundColor)
                            .padding()
                    })
                    .buttonStyle(BorderlessButtonStyle())  // workaround so that button can be tapped
                    Spacer()
                }
                
                if isShowingDeckComment {
                    TextView(text: $editableText) {
                        $0.isEditable = true
                        $0.backgroundColor = theme.currentBackgroundColorUI
                        $0.font = UIFont(name: theme.currentFont, size: 13)
                        $0.textColor = theme.currentTextColorUI
                    }
                    .frame(height: 150)
                    .onAppear {
                        self.editableText = deck.wrappedDeckComment
                    }
                    .onDisappear(perform: {
                        deck.deckComment = self.editableText
                    })
                }
                
                Spacer()
            }
            .listRowBackground(
                RoundedRectangle(cornerRadius: 8)
                    .background(.clear)
                    .foregroundColor(theme.currentBackgroundColor)
                    .padding(
                        EdgeInsets(
                            top: 5,
                            leading: 0,
                            bottom: 5,
                            trailing: 0
                        )
                    )
            )

            //.listRowBackground(theme.currentBackgroundColor)
                        
            ForEach(deck.childCardsArray, id: \.id) { card in
                CardCell(card: card)
                
            }.onDelete(perform: deleteCard)
            .listRowBackground(
                RoundedRectangle(cornerRadius: 8)
                    .background(.clear)
                    .foregroundColor(theme.currentBackgroundColor)
                    .padding(
                        EdgeInsets(
                            top: 5,
                            leading: 20,
                            bottom: 5,
                            trailing: 20
                        )
                    )
            )
            .listRowSeparator(.hidden)
        }
        .background(BackgroundCardView().scaledToFit())
        .scrollContentBackground(.hidden)
        .sheet(isPresented: $isPresented) {
            AddCardView {newCardName, newCardComment in
                self.addCard(newCardName: newCardName, newCardComment: newCardComment)
                self.isPresented = false
            }
        }
        .toolbarBackground(
            theme.currentBackgroundColor,
            for: .tabBar, .navigationBar)
        .toolbarBackground(.visible, for: .tabBar, .navigationBar)
        .toolbar {
            ToolbarItem(placement: .principal) {
                        VStack {
                            Text("Deck Details")
                                .font(Font(UIFont(name: theme.currentFont, size: 24)!))
                              .foregroundColor(Color.white)
                        }
                    }
                }
        .navigationBarItems(trailing: Button(action: {
            self.isPresented.toggle()
        }, label: {
            Image(systemName: "plus")
                .imageScale(.small)
        }))
    }

    
    
    
    
    func deleteCard(at offsets: IndexSet) {
        offsets.forEach { index in
            let card = self.deck.childCardsArray[index]
            self.managedObjectContext.delete(card)
            
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
