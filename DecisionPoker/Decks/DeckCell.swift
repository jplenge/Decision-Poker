//
//  DeckCell.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 29.06.20.
//  Copyright © 2020 Jodi Szarko. All rights reserved.
//

import SwiftUI

struct DeckCell: View {
    @ObservedObject var deck: Deck
    
    @State var isShowingResultView = false
    @State var isShowingComment = false
    @State var editableText = ""
    @State var editableTextField = ""
    @State var stepperValue = 0
    @State var low = 1
    
    @State var gameResult: [Card] = []

    
    var body: some View {
        
        let view = ZStack {
            
            VStack {
                
                HStack {
                    TextField(deck.wrappedDeckName, text: $editableTextField, onCommit: saveTitle)
                        .multilineTextAlignment(.center)
                        .scaledFont(name: Theme.currentFont, size: 28)
                        .padding()
                        .foregroundColor(Theme.currentTextColor)
                        .onAppear(perform: {
                            editableTextField = deck.wrappedDeckName
                        })
                    
                    
                    Button(action: {
                        self.isShowingComment.toggle()
                    }) {
                        Image(systemName: "info.circle")
                            .frame(width: 40, height: 40)
                            .foregroundColor(Theme.currentButtonBackgroundColor)
                            .padding()
                    }.buttonStyle(BorderlessButtonStyle())  // workaround so that button can be tapped
                }
                
                
                if isShowingComment {
                    
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
                
                
                HStack {
                    Spacer()
                    
                    Text("Total: \(deck.childCardsCount) cards")
                        .scaledFont(name: Theme.currentFont, size: 16)
                        .foregroundColor(Theme.currentTextColor)
                    
                    Spacer()
                    
                    Text("Active: \(deck.activeCards) cards")
                        .scaledFont(name: Theme.currentFont, size: 16)
                        .foregroundColor(Theme.currentTextColor)
                    
                    
                    Spacer()
                }
                
                Spacer()      
                
                HStack {
                    
                    Spacer()
                    
                    Text(LocalizedStringKey("Select: \(deck.numberOfCardsToPick) cards"))
                        .scaledFont(name: Theme.currentFont, size: 16)
                        .foregroundColor(Theme.currentTextColor)
                    
                    Spacer()
                        .frame(width: 10)
                    
//                   Stepper("", onIncrement: {
//                        if  self.deck.numberOfCardsToPick  < Int16(self.deck.activeCards) {
//                            self.deck.numberOfCardsToPick += 1
//                        }
//
//                    }, onDecrement: {
//                        if  self.deck.numberOfCardsToPick  > 1  {
//                            self.deck.numberOfCardsToPick -= 1
//                        }
//                    })
                    Stepper("", value: $stepperValue, in: low...self.deck.activeCards, step: 1, onEditingChanged: {didChange in
                        self.deck.numberOfCardsToPick = Int16(self.stepperValue)
                    })
                    .onAppear(){
                        
                        if self.deck.activeCards == 0 {
                            self.deck.numberOfCardsToPick = 0
                            self.low = 0
                        } else if self.deck.numberOfCardsToPick > self.deck.activeCards {
                            self.deck.numberOfCardsToPick = Int16(self.deck.activeCards)
                        }
                        self.stepperValue = Int(self.deck.numberOfCardsToPick)
                    }
                    .frame(width: 80)
                    .background(Theme.currentTextColor)
                    .cornerRadius(10)
                    
                    Spacer()
                }
                
                Spacer()
                
                VStack {
                    
                    
                    List {
                        NavigationLink(destination: DealResultSwiftUIView(selectedDeck: deck, results: gameResult), isActive: $isShowingResultView) { EmptyView()}
                    }.frame(height: 0)
                    
                    Button(action: {
                        gameResult = deck.playGame()
                        self.isShowingResultView = true
                    }){
                        Text("Deal")
                            .scaledFont(name: Theme.currentFont, size: 20)
                            .padding(.horizontal)
                    }.buttonStyle(StartViewButtonStyle(backcolor: Theme.currentButtonBackgroundColor, forecolor: Theme.currentBackgroundColor))
                }
                
                Spacer()
            }
        }
        return view
    }
    
    
    func updateDeckComment(){
        deck.deckComment = editableText
    }
    
    func saveTitle(){
        deck.deckName = editableTextField
    }
    
    
}

