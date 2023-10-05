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
    @Binding var path: NavigationPath
    @State private var isAlreadySaved: Bool = false
    @State private var showActionSheet: Bool = false
    @ObservedObject var viewModel: ViewModel
    @AppStorage("SelectedColor") private var selectedColor: Int = 0
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        ZStack {
            List {
                HStack(alignment: .center) {
                    Spacer()
                    Text(viewModel.selectedDeck.wrappedDeckName)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(("AccentColor")))
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding()
                    Spacer()
                }.listRowBackground(
                    RoundedRectangle(cornerRadius: 20)
                        .background(.clear)
                        .foregroundColor(theme.colors[selectedColor])
                        .padding(
                            EdgeInsets(
                                top: 5,
                                leading: 0,
                                bottom: 5,
                                trailing: 0
                            )
                        )
                )
                
                ForEach(viewModel.gameResult.indices, id: \.self) { index in
                    HStack {
                        Spacer()
                        Text(viewModel.gameResult[index].wrappedCardName)
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color("AccentColor"))
                            .font(.body)
                            .padding()
                        
                        Spacer()
                    }
                }
                .listRowBackground(
                    RoundedRectangle(cornerRadius: 20)
                        .background(.clear)
                        .foregroundColor(theme.colors[selectedColor])
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
                    self.isAlreadySaved = false
                }
            }
            .scrollContentBackground(.hidden)
            .navigationBarItems(trailing:
                                    Button(action: {
                                        self.showActionSheet = true
                                    }, label: {
                                        Image(systemName: "square.and.arrow.up").imageScale(.large)
                                            .imageScale(.medium)
                                            .fontWeight(.bold)
                                            .fontDesign(.rounded)
                                    })
            )
            
            HStack {
                VStack {
                    Spacer()
                        Button(action: {
                            self.saveResults(deck: viewModel.selectedDeck, cards: viewModel.gameResult)
                            self.saveLastDecision(deck: viewModel.selectedDeck, cards: viewModel.gameResult)
                            WidgetCenter.shared.reloadAllTimelines()
                            self.isAlreadySaved = true
                        }, label: {
                            Text("\(isAlreadySaved ? LocalizedStringResource(stringLiteral:"Already Saved") : LocalizedStringResource(stringLiteral: "Save"))")
                                .fontWeight(.bold)
                                .fontDesign(.rounded)
                        })
                        .buttonStyle(StartViewButtonStyle(backcolor: Color("AccentColor").opacity(isAlreadySaved ? 0.5 : 1.0),
                                                          forecolor: theme.colors[selectedColor]))
                        .disabled(isAlreadySaved)
                    .padding([.horizontal, .bottom])
                    
                }
                
                VStack {
                    Spacer()
                        Button(action: {
                            path.removeLast(path.count)
                        }, label: {
                            Text("Done")
                                .fontWeight(.bold)
                                .fontDesign(.rounded)
                        })
                        .buttonStyle(StartViewButtonStyle(backcolor: Color("AccentColor"),
                                                          forecolor: theme.colors[selectedColor]))
                        .padding([.horizontal, .bottom])
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .background {
            BackgroundCardView(cols: 20, rows: 20).scaledToFit()
        }
        .toolbarBackground(.visible, for: .tabBar, .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("Final Decision")
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                        .foregroundColor(theme.colors[selectedColor])
                }
            }
        }
        .sheet(isPresented: $showActionSheet, onDismiss: {
            print("Dismiss")
        }, content: {
            ActivityViewController(activityItems: [generateShareString(deck: viewModel.selectedDeck, cards: viewModel.gameResult)])
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
            print(error)
        }
    }
}
