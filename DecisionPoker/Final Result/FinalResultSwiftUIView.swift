//
//  FinalResultSwiftUIView.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 02.07.20.
//  Copyright © 2020 Jodi Szarko. All rights reserved.
//

import SwiftUI
import CoreData
import UIKit
import WidgetKit

struct FinalResultSwiftUIView: View {
    var selectedDeck: Deck
    var results: [Card]
    
    @Binding var path: NavigationPath
    
    @State private var isShowingSavedResults: Bool = false
    @State private var showActionSheet: Bool = false
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        ZStack {
            List {
                HStack(alignment: .center) {
                    Spacer()
                    Text(selectedDeck.wrappedDeckName)
                        .multilineTextAlignment(.center)
                        .scaledFont(name: theme.currentFont, size: 22)
                        .foregroundColor(theme.currentTextColor)
                        .padding()
                    Spacer()
                }.listRowBackground(
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
                
                ForEach(self.results.indices) { index in
                    HStack {
                        Spacer()
                        Text(self.results[index].wrappedCardName)
                            .multilineTextAlignment(.center)
                            .scaledFont(name: theme.currentFont, size: 18)
                            .foregroundColor(theme.currentTextColor)
                            .padding()
                        
                        Spacer()
                    }
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
                .scrollContentBackground(.hidden)
                .onAppear {
                    self.isShowingSavedResults = false
                }
            }
            .scrollContentBackground(.hidden)
            
            HStack {
                
                VStack {
                    Spacer()
                        Button(action: {
                            self.showActionSheet = true
                        }, label: {
                            Image(systemName: "square.and.arrow.up").imageScale(.large)
                        })
                        .buttonStyle(StartViewButtonStyle(backcolor: theme.currentButtonBackgroundColor, forecolor: theme.currentBackgroundColor))
                    .padding([.horizontal, .bottom])
                }
                
                VStack {
                    Spacer()
                        Button(action: {
                            self.saveResults(deck: self.selectedDeck, cards: self.results)
                            self.saveLastDecision(deck: self.selectedDeck, cards: self.results)
                            WidgetCenter.shared.reloadAllTimelines()
                            self.isShowingSavedResults = true
                        }, label: {
                            Text("Save").scaledFont(name: theme.currentFont, size: 26)
                        })
                        .buttonStyle(StartViewButtonStyle(backcolor: theme.currentButtonBackgroundColor,
                                                          forecolor: theme.currentBackgroundColor))
                    .navigationDestination(isPresented: $isShowingSavedResults, destination: { SavedResultsSwiftUIView(showBackButton: .constant(true), path: $path)})
                    .padding([.horizontal, .bottom])
                    
                }
                
                VStack {
                    Spacer()
                        Button(action: {
                            path.removeLast(path.count)
                        }, label: {
                            Text("Done").scaledFont(name: theme.currentFont, size: 26)
                        })
                        .buttonStyle(StartViewButtonStyle(backcolor: theme.currentButtonBackgroundColor, forecolor: theme.currentBackgroundColor))
                        .padding([.horizontal, .bottom])
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .background {
            BackgroundCardView(cols: 20, rows: 20).scaledToFit()
        }
        //.background(BackgroundCardView().scaledToFit())
        .toolbarBackground(
            theme.currentBackgroundColor,
            for: .tabBar, .navigationBar)
        .toolbarBackground(.visible, for: .tabBar, .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("Final Decision")
                        .font(Font(UIFont(name: theme.currentFont, size: 24)!))
                        .foregroundColor(Color.white)
                }
            }
        }
        .sheet(isPresented: $showActionSheet, onDismiss: {
            print("Dismiss")
        }, content: {
            ActivityViewController(activityItems: [generateShareString(deck: self.selectedDeck, cards: self.results)])
        })
    }
    
    func generateShareString(deck: Deck, cards: [Card]) -> String {
        var resultString: String
        resultString = "Deck: \(String(deck.deckName ?? ""))\r"
        resultString += "\r Selected cards:\r"
        
        for item in cards {
            resultString += "- \(String(item.cardName ?? ""))\r"
        }
        
        return resultString
    }
    
    func saveLastDecision(deck: Deck, cards: [Card]) {
        var selectedCards: [String] = []
        
        for card in cards {
            selectedCards.append(card.wrappedCardName)
        }
        
        let lastDecision = Decision(deckname: deck.wrappedDeckName, date: Date(), selectedCards: selectedCards)
        
        saveJSON(named: "lastDecision", object: lastDecision)
    }
    
    func saveResults(deck: Deck, cards: [Card]) {
        let savedDeck = SavedDeck(context: managedObjectContext)
        savedDeck.deckName = deck.deckName
        savedDeck.deckComment =  deck.deckComment
        savedDeck.id = UUID()
        savedDeck.dateSaved = Date()
        
        for card in cards {
            let newSavedCard = SavedCard(context: managedObjectContext)
            newSavedCard.cardName = card.cardName
            newSavedCard.cardComment = card.cardComment
            newSavedCard.id = UUID()
            savedDeck.addToSavedChildCards(newSavedCard)
        }
        
        do {
            try managedObjectContext.save()
        } catch {
            // TODO - add error checking
            print(error)
        }
    }
}
