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
    
    @State var isShowingSavedResults: Bool = false
    @State private var showActionSheet: Bool = false
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    // required for going home to first screen
    @EnvironmentObject var appState: AppState

    var body: some View {
        let view = ZStack {
            
            VStack {
                Image("Card Hand Image")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                VStack {
                    Text("Here is your result for")
                        .scaledFont(name: theme.currentFont, size: 18)
                        .foregroundColor(theme.currentTextColor)
                    
                    Text(selectedDeck.wrappedDeckName)
                        .scaledFont(name: theme.currentFont, size: 22)
                        .foregroundColor(theme.currentTextColor)
                        .padding()
                }
                
                List {
                    ForEach(self.results.indices) { index in
                        HStack {
                            Spacer()
                            Text(self.results[index].wrappedCardName)
                                .multilineTextAlignment(.center)
                                .scaledFont(name: theme.currentFont, size: 18)
                                .foregroundColor(theme.currentTextColor)
                            
                            Spacer()
                        }
                    }
                    .listRowBackground(theme.currentBackgroundColor)
                }
                .onAppear {
                    self.isShowingSavedResults = false
                }
                .listRowBackground(theme.currentBackgroundColor)
            }
            .background(theme.currentBackgroundColor)
            
            HStack {
                Spacer()
                VStack {
                    
                    Spacer()
                    
                    Group {
                        NavigationLink(destination: SavedResultsSwiftUIView(showBackButton: .constant(true)), isActive: $isShowingSavedResults) { EmptyView() }
                            .isDetailLink(false)
                        
                        Button(action: {
                                self.saveResults(deck: self.selectedDeck, cards: self.results)
                                self.saveLastDecision(deck: self.selectedDeck, cards: self.results)
                            if #available(iOS 14.0, *) {
                                WidgetCenter.shared.reloadAllTimelines()
                            } else {
                                // Fallback on earlier versions
                            }
                                self.isShowingSavedResults = true
                        }, label: {
                            Text("Save").scaledFont(name: theme.currentFont, size: 26)
                        })
                        .buttonStyle(StartViewButtonStyle(backcolor: theme.currentButtonBackgroundColor,
                                                          forecolor: theme.currentBackgroundColor))
                    
                    }
                    .padding(.bottom, 5)
                    .padding(.horizontal)
                    
                    Group {
                        
                        Button(action: {
                            self.appState.moveToRoot = true
                        }, label: {
                            Text("Done").scaledFont(name: theme.currentFont, size: 26)
                        })
                        .buttonStyle(StartViewButtonStyle(backcolor: theme.currentButtonBackgroundColor, forecolor: theme.currentBackgroundColor))
                    
                    }.padding(.top, 5)
                    .padding([.horizontal, .bottom])
                    
                }
            }
            
            HStack {
                VStack {
                    Spacer()
                    Group {
                        
                        Button(action: {
                            self.showActionSheet = true
                        }, label: {
                            Image(systemName: "square.and.arrow.up").imageScale(.large)
                        })
                        .buttonStyle(StartViewButtonStyle(backcolor: theme.currentButtonBackgroundColor, forecolor: theme.currentBackgroundColor))
                        
                    }.padding()
                }
                Spacer()
            }
            
        }
        .sheet(isPresented: $showActionSheet, onDismiss: {
            print("Dismiss")
        }, content: {
            ActivityViewController(activityItems: [generateShareString(deck: self.selectedDeck, cards: self.results)])
        })
        
        return view
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
