//
//  DealResultSwiftUIView.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 01.07.20.
//  Copyright © 2020 Jodi Szarko. All rights reserved.
//

import SwiftUI

struct DealResultSwiftUIView: View {
   
    @Binding var selectedDeck: Deck
    @Binding var results: [Card]
    @Binding var path: NavigationPath
    
    @State var nextScreen: Bool = false

    @Environment(\.managedObjectContext) var managedObjectContext
    
 

    var body: some View { 
        ZStack {
            List {
                ForEach(results.indices, id: \.self) {index  in
                    ResultViewCell(card: self.results[index], index: index, selectedDeck: self.selectedDeck, results: self.$results)
                }
                .listRowBackground(
                    RoundedRectangle(cornerRadius: 8)
                        .background(.clear)
                        .foregroundColor(theme.currentBackgroundColor)
                        .padding(
                            EdgeInsets(
                                top: 5,
                                leading: 10,
                                bottom: 5,
                                trailing: 10
                            )
                        )
                )
                .listRowSeparator(.hidden)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                            VStack {
                                Text("First Hand")
                                    .font(Font(UIFont(name: theme.currentFont, size: 24)!))
                                  .foregroundColor(Color.white)
                            }
                        }
                    }
            .toolbarBackground(
                theme.currentBackgroundColor,
                for: .tabBar, .navigationBar)
            .toolbarBackground(.visible, for: .tabBar, .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .scrollContentBackground(.hidden)
            
            VStack {
                Spacer()
                VStack {
                    Button(action: {
                        nextScreen = true
                    }, label: {
                        Text("Hold 'em!")
                            .scaledFont(name: theme.currentFont, size: 26)
                    }).buttonStyle(StartViewButtonStyle(backcolor: theme.currentButtonBackgroundColor, forecolor: theme.currentBackgroundColor))
                    .padding()
                }
                
            }
        }
        .navigationBarBackButtonHidden(true)
        .background(BackgroundCardView().scaledToFit())
        .navigationDestination(isPresented: $nextScreen, destination: { FinalResultSwiftUIView(selectedDeck:selectedDeck, results: results, path: $path) } )
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
