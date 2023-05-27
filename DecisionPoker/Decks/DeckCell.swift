//
//  DeckCell.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 29.06.20.
//  Copyright © 2020 Jodi Szarko. All rights reserved.
//

import SwiftUI

struct DeckCell: View {
    var deck: Deck
    @Binding var path: NavigationPath
    @State var isShowingComment = false
    @State var editableText = ""
    @State var editableTextField = ""
    @State var stepperValue = 0
    @State var low = 1
    @Binding var gameResult: [Card]
    @Binding var selectedDeck: Deck

    var body: some View {
        let view = ZStack {
            VStack {
                HStack {
                    TextField(deck.wrappedDeckName, text: $editableTextField, onCommit: saveTitle)
                        .multilineTextAlignment(.center)
                        .scaledFont(name: theme.currentFont, size: 22)
                        .padding()
                        .foregroundColor(theme.currentTextColor)
                        .onAppear(perform: {
                            editableTextField = deck.wrappedDeckName
                        })
                    
                    Button(action: {
                        self.isShowingComment.toggle()
                    }, label: {
                        Image(systemName: "info.circle")
                            .frame(width: 40, height: 40)
                            .foregroundColor(theme.currentButtonBackgroundColor)
                            .padding()
                    }).buttonStyle(BorderlessButtonStyle())  // workaround so that button can be tapped
                }
                
                if isShowingComment {
                    
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
                
                HStack {
                    Spacer()
                    
                    Text("Total: \(deck.childCardsCount) cards")
                        .scaledFont(name: theme.currentFont, size: 16)
                        .foregroundColor(theme.currentTextColor)
                    
                    Spacer()
                    
                    Text("Active: \(deck.activeCards) cards")
                        .scaledFont(name: theme.currentFont, size: 16)
                        .foregroundColor(theme.currentTextColor)
                    
                    Spacer()
                }
                
                Spacer()
                
                HStack {
                    
                    Spacer()
                    
                    Text(LocalizedStringKey("Select: \(deck.numberOfCardsToPick) cards"))
                        .scaledFont(name: theme.currentFont, size: 16)
                        .foregroundColor(theme.currentTextColor)
                    
                    Spacer()
                        .frame(width: 10)
                    
                    Stepper("", value: $stepperValue, in: 0...self.deck.activeCards, step: 1, onEditingChanged: {_ in
                        self.deck.numberOfCardsToPick = Int16(self.stepperValue)
                    })
                    .onAppear {
                        if self.deck.activeCards == 0 {
                            self.deck.numberOfCardsToPick = 0
                            self.low = 0
                        } else if self.deck.numberOfCardsToPick > self.deck.activeCards {
                            self.deck.numberOfCardsToPick = Int16(self.deck.activeCards)
                        }
                        self.stepperValue = Int(self.deck.numberOfCardsToPick)
                    }
                    .frame(width: 80)
                    .background(theme.currentTextColor)
                    .cornerRadius(10)
                    
                    Spacer()
                }
                
                Spacer()
                
                VStack {
                    Button(action: {
                        gameResult = self.deck.playGame()
                        selectedDeck = deck
                        path.append("ResultView")
                    }, label: {
                        Text("Deal")
                            .scaledFont(name: theme.currentFont, size: 20)
                            .padding(.horizontal)
                    })
                    .buttonStyle(StartViewButtonStyle(backcolor: theme.currentButtonBackgroundColor, forecolor: theme.currentBackgroundColor))
                }
                Spacer()
            }
//            .navigationDestination(for: String.self) { _ in
//                DealResultSwiftUIView(selectedDeck: self.deck, results: gameResult, path: self.$path)
//            }
        }
        return view
    }
    
    private func updateDeckComment() {
        deck.deckComment = editableText
    }
    
    private func saveTitle() {
        deck.deckName = editableTextField
    }
}
