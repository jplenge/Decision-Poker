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
    @AppStorage("SelectedColor") private var selectedColor: Int = 0
    
    var body: some View {
        
        List {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                        TextField(deck.wrappedDeckName, text: $editableTextField, axis: .vertical)
                        .lineLimit(...3)
                        .multilineTextAlignment(.center)
                        .padding(.top, 10)
                        .foregroundColor(Color("AccentColor"))
                        .fontWeight(.bold)
                        .font(.title3)
                        .onAppear {
                            editableTextField = deck.wrappedDeckName
                        }
                        .onSubmit {
                            deck.deckName = editableTextField
                            do {
                                try self.managedObjectContext.save()
                            } catch {
                                print(error)
                            }
                        }

                    Button(action: {
                        self.isShowingDeckComment.toggle()
                    }, label: {
                        Image(systemName: "info.circle")
                            .frame(width: 22, height: 22)
                            .foregroundColor(Color("AccentColor"))
                            .padding()
                    })
                    .buttonStyle(BorderlessButtonStyle())
                    .padding(.top, 10)// workaround so that button can be tapped
                    Spacer()
                }
                
                if isShowingDeckComment {
                    TextField(deck.wrappedDeckComment, text: $editableText, axis: .vertical)
                        .onAppear {
                            self.editableText = deck.wrappedDeckComment
                        }
                        .onSubmit {
                            deck.deckComment = self.editableText
                            do {
                                try self.managedObjectContext.save()
                            } catch {
                                print(error)
                            }
                        }
                        .lineLimit(...6)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color("AccentColor"))
                        .font(.footnote)
//                    TextView(text: $editableText) {
//                        $0.isEditable = true
//                        $0.backgroundColor = UIColor(themeColor.colors[selectedColor])
//                        $0.textColor = UIColor(Color("AccentColor"))
//                    }
//                    .frame(height: 150)
//                    .onAppear {
//                        self.editableText = deck.wrappedDeckComment
//                    }
//                    .onDisappear(perform: {
//                        deck.deckComment = self.editableText
//                    })
                }
                
                Spacer()
            }
            .listRowBackground(
                RoundedRectangle(cornerRadius: 20)
                    .background(.clear)
                    .foregroundColor(themeColor.colors[selectedColor])
                    .padding(
                        EdgeInsets(
                            top: 5,
                            leading: 0,
                            bottom: 5,
                            trailing: 0
                        )
                    )
            )
                        
            ForEach(deck.childCardsArray, id: \.id) { card in
                CardCell(card: card)
            }.onDelete(perform: deleteCard)
            .listRowBackground(
                RoundedRectangle(cornerRadius: 20)
                    .background(.clear)
                    .foregroundColor(themeColor.colors[selectedColor])
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
            themeColor.colors[selectedColor],
            for: .tabBar, .navigationBar)
        .toolbarBackground(.visible, for: .tabBar, .navigationBar)
        .toolbar {
            ToolbarItem(placement: .principal) {
                        VStack {
                            Text("Deck Details")
                              .foregroundColor(Color("AccentColor"))
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
        do {
            try self.managedObjectContext.save()
        } catch {
            print(error)
        }
    }
}
