//
//  DealResultSwiftUIView.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 01.07.20.
//  Copyright © 2020 Jodi Szarko. All rights reserved.
//

import SwiftUI

struct DealResultSwiftUIView: View {
    
    var selectedDeck: Deck
    
    @State var results: [Card]
    
    @State var isShowingFinalResultView: Bool = false
    
    @Binding var path: NavigationPath

    @Environment(\.managedObjectContext) var managedObjectContext

    var body: some View {   
        ZStack {
            List {
                ForEach(results.indices, id: \.self) {index  in
                    ResultViewCell(card: self.results[index], index: index, selectedDeck: self.selectedDeck, results: self.$results)
                }
                .listRowBackground(theme.currentBackgroundColor)
            }
            .navigationTitle("First Hand")
            .navigationBarTitleDisplayMode(.inline)
            .background(theme.currentBackgroundColor)
            .scrollContentBackground(.hidden)
            
            VStack {
                Spacer()
                VStack {
                    Button(action: {
                        path.append(Selected.finalresultview)
                        // self.isShowingFinalResultView = true
                    }, label: {
                        Text("Hold 'em!")
                            .scaledFont(name: theme.currentFont, size: 26)
                    }).buttonStyle(StartViewButtonStyle(backcolor: theme.currentButtonBackgroundColor, forecolor: theme.currentBackgroundColor))
                    .padding()
                }
                
            }
        }
        .navigationDestination(for: Selected.self) { _ in
            FinalResultSwiftUIView(selectedDeck: selectedDeck,
                                                   results: results,
                                                path: $path)
        }
//        .navigationDestination(isPresented: $isShowingFinalResultView,
//                               destination: {  FinalResultSwiftUIView(selectedDeck: selectedDeck,
//                                                                      results: results) })
    }
    
    enum Selected {
        case finalresultview
    }
    
    struct ResultViewCell: View {
        @State var card: Card
        @State var index: Int
        var selectedDeck: Deck
        
        @Binding var results: [Card]
        
        @State var cheatPickerIsPresented = false
        
        var body: some View {
            
            VStack {
                Text(card.wrappedCardName)
                    .multilineTextAlignment(.center)
                    .scaledFont(name: theme.currentFont, size: 28)
                    .padding()
                    .foregroundColor(theme.currentTextColor)
                HStack {
                    
                    Button(action: {
                        self.cheatPickerIsPresented = true
                    }, label: {
                        Text("Cheat")
                            .scaledFont(name: theme.currentFont, size: 14)
                    }).buttonStyle(StartViewButtonStyle(backcolor: theme.currentButtonBackgroundColor, forecolor: theme.currentBackgroundColor))
                    
                    Spacer()
                    
                    Button(action: {
                        self.results[self.index] = self.selectedDeck.repickCard(selectedCards: self.results, current: self.results[self.index])
                        self.card =  self.results[self.index]
                        print(self.results[self.index])
                    }, label: {
                        Text("Redraw")
                            .scaledFont(name: theme.currentFont, size: 14)
                    }).buttonStyle(StartViewButtonStyle(backcolor: theme.currentButtonBackgroundColor, forecolor: theme.currentBackgroundColor))
                }
            }.sheet(isPresented: $cheatPickerIsPresented) {
                let possibleCards = updateSelection(possibleCards: selectedDeck.childCardsActiveArray,
                                                    selectedCards: results,
                                                    currentCard: self.results[self.index])
                let firstIndex = possibleCards.firstIndex(of: self.results[self.index])
                
                CheatPickerView(pickedCard: self.results[self.index], selectedIndex: firstIndex ?? 0, possibleCards: possibleCards, onComplete: { pickedCard in
                    self.results[self.index]  = pickedCard
                    self.card =  self.results[self.index]
                    self.cheatPickerIsPresented = false
                })
            }
        }
        
    }
}

private func updateSelection(possibleCards: [Card], selectedCards: [Card], currentCard: Card) -> [Card] {
    
    var filtered: [Card] = []
    
    for index in 0..<possibleCards.count {
        if !selectedCards.contains(possibleCards[index]) || possibleCards[index] == currentCard {
            filtered.append(possibleCards[index])
        }
    }
    
    return filtered
}
