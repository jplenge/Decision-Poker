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
    @ObservedObject var viewModel: ViewModel
   
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @AppStorage("SelectedColor") private var selectedColor: Int = 0

    var body: some View {
        let view = ZStack {
            VStack {
                HStack {
                    TextField(deck.wrappedDeckName, text: $editableTextField, axis: .vertical)
                        .lineLimit(...3)
                        .multilineTextAlignment(.center)
                        .padding(.top, 10)
                        .foregroundColor(Color("AccentColor"))
                        .fontWeight(.bold)
                        .font(.title3)
                        .fontDesign(.rounded)
                        .keyboardType(.default)
                        .submitLabel(.done)
                        .onAppear {
                            editableTextField = deck.wrappedDeckName
                        }
                        .onSubmit {
                            saveTitle()
                        }
                    
                    Button(action: {
                        self.isShowingComment.toggle()
                    }, label: {
                        Image(systemName: "info.circle")
                            .frame(width: 40, height: 40)
                            .foregroundColor(Color("AccentColor"))
                            .padding(.top, 10)
                    }).buttonStyle(BorderlessButtonStyle())  // workaround so the button can be tapped
                }
                
                if isShowingComment {
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
                        .font(.subheadline)
                }
                
                HStack {
                    Spacer()
                    
                        (Text("Total: ")
                        + Text("\(deck.childCardsCount) ")
                        + Text("cards"))
                        .font(.body)
                        .fontDesign(.rounded)
                        .foregroundColor(Color("AccentColor"))
                    
                    Spacer()
                    
                    (Text("Active: ")
                    + Text("\(deck.activeCards) ")
                    + Text("\(deck.activeCards > 1 ? LocalizedStringResource(stringLiteral: "cards") : LocalizedStringResource(stringLiteral: "card"))"))
                        .font(.body)
                        .fontDesign(.rounded)
                        .foregroundColor(Color("AccentColor"))
                    Spacer()
                }
                
                Spacer()
                
                HStack {
                    
                    Spacer()
                    
                    (Text("Select: \(deck.numberOfCardsToPick, specifier: "%ld")") + Text(" \(deck.numberOfCardsToPick > 1 ? LocalizedStringResource(stringLiteral: "cards")  : LocalizedStringResource(stringLiteral: "card") )"))
                    
                        .font(.body)
                        .fontDesign(.rounded)
                        .foregroundColor(Color("AccentColor"))
                    
                    Spacer()
                        .frame(width: 15)
                    
                    Stepper("", value: $stepperValue, in: 0...self.deck.activeCards, step: 1, onEditingChanged: {_ in
                        self.deck.numberOfCardsToPick = Int16(self.stepperValue)
                        do {
                            try self.managedObjectContext.save()
                        } catch {
                            print(error)
                        }
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
                    .tint(theme.colors[selectedColor])
                    .frame(width: 80)
                    .background(Color("AccentColor"))
                    .cornerRadius(10)
                
                    Spacer()
                }
                
                Spacer()
                
                VStack {
                    Button(action: {
                        viewModel.gameResult = self.deck.playGame()
                        self.viewModel.selectedDeck = deck
                        path.append("ResultView")
                    }, label: {
                        Text("deck.deal.button.label")
                            .fontWeight(.bold)
                            .fontDesign(.rounded)
                            .padding(.horizontal)
                    })
                    .accessibilityIdentifier("deal.btn")
                    .buttonStyle(StartViewButtonStyle(backcolor: Color("AccentColor"), forecolor: theme.colors[selectedColor]))
                }
                Spacer()
            }
        }
        return view
    }
    
    private func updateDeckComment() {
        deck.deckComment = editableText
        
        do {
            try self.managedObjectContext.save()
        } catch {
            print(error)
        }
    }
    
    private func saveTitle() {
        deck.deckName = editableTextField
        
        do {
            try self.managedObjectContext.save()
        } catch {
            print(error)
        }
    }
}
