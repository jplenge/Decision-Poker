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
    
    @Environment(\.managedObjectContext) var managedObjectContext
       
    var body: some View {   
        ZStack {
            List {
                ForEach(results.indices, id: \.self) {index  in
                    ResultViewCell(card: self.results[index], index: index, selectedDeck: self.selectedDeck, results: self.$results)
                }
                .listRowBackground(theme.currentBackgroundColor)
            }.navigationBarTitle("First Hand", displayMode: .inline)
            .onAppear(perform: {
                UITableView.appearance().backgroundColor = .clear // tableview background
                UITableViewCell.appearance().backgroundColor = .clear // cell background
            })
            .listRowBackground(theme.currentBackgroundColor)
            
            VStack {
                Spacer()
                VStack {
                    NavigationLink(destination: FinalResultSwiftUIView(selectedDeck: selectedDeck, results: results),
                                   isActive: $isShowingFinalResultView) { EmptyView() }
                    Button(action: {
                        self.isShowingFinalResultView = true
                    }) {
                        Text("Hold 'em!")
                            .scaledFont(name: theme.currentFont, size: 26)
                    }.buttonStyle(StartViewButtonStyle(backcolor: theme.currentButtonBackgroundColor, forecolor: theme.currentBackgroundColor))
                    .padding()
                }
                
            }
        }
        .background(theme.currentBackgroundColor)
        
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
                    }) {
                        Text("Cheat")
                            .scaledFont(name: theme.currentFont, size: 14)
                    }.buttonStyle(StartViewButtonStyle(backcolor: theme.currentButtonBackgroundColor, forecolor: theme.currentBackgroundColor))
                    
                    Spacer()
                    
                    Button(action: {
                        self.results[self.index] = self.selectedDeck.repickCard(selectedCards: self.results, current: self.results[self.index])
                        self.card =  self.results[self.index]
                        print(self.results[self.index])
                    }) {
                        Text("Redraw")
                            .scaledFont(name: theme.currentFont, size: 14)
                    }.buttonStyle(StartViewButtonStyle(backcolor: theme.currentButtonBackgroundColor, forecolor: theme.currentBackgroundColor))
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
