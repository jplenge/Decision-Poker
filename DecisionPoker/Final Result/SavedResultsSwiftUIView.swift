//
//  SavedResultsSwiftUIView.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 24.06.20.
//  Copyright © 2020 Jodi Szarko. All rights reserved.
//

import SwiftUI
import CoreData
import WidgetKit

struct  SavedResultsSwiftUIView: View {
    
    @Binding var showBackButton: Bool
    
    @Binding var path: NavigationPath

    @State private var showActionSheet: Bool = false
    @State private var sharedString: String = ""
    
    init(showBackButton: Binding<Bool>, path: Binding<NavigationPath>) {
        self._showBackButton = showBackButton
        self._path = path
        UITableView.appearance().allowsSelection = true
    }
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    // fetch hstory from core data
    @FetchRequest(entity: SavedDeck.entity(), sortDescriptors: [NSSortDescriptor(
        key: "dateSaved",
        ascending: false
    )]) var savedDecks: FetchedResults<SavedDeck>

    var body: some View {
        let view =  ZStack {
            List {
                ForEach(savedDecks, id:\.self) { deck in
                    ZStack {
                        VStack {
                            HStack {
                                Spacer()
                                Text(deck.wrappedDeckName)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                                    .scaledFont(name: theme.currentFont, size: 22)
                                    .foregroundColor(theme.currentTextColor)
                                    .padding()
                                Spacer()
                            }
                            Spacer()
                            VStack(alignment: .leading) {
                                ForEach(deck.savedCardsArray, id: \.self) { card in
                                    Text("• \(card.wrappedCardName)")
                                        .multilineTextAlignment(.leading)
                                        .scaledFont(name: theme.currentFont, size: 16)
                                        .foregroundColor(theme.currentTextColor)
                                }.listRowBackground(theme.currentBackgroundColor)
                            }
                            Spacer()
                            HStack {
                                Text("created: \(deck.creationDateFormatted)")
                                    .multilineTextAlignment(.leading)
                                    .scaledFont(name: theme.currentFont, size: 8)
                                    .foregroundColor(theme.currentTextColor)
                                Spacer()
                            }
                        }
                        
                        HStack {
                            Spacer()
                            VStack {
                                Spacer()
                                Group {
                                    Button(action: {
                                        self.sharedString  = generateShareString(deck: deck)
                                        self.showActionSheet = true
                                    }, label: {
                                        Image(systemName: "square.and.arrow.up")
                                            .imageScale(.small)
                                    })
                                    .buttonStyle(StartViewButtonStyle(backcolor: theme.currentButtonBackgroundColor,
                                                                      forecolor: theme.currentBackgroundColor))
                                }
                            }
                        }
                    }
                }
                .onDelete(perform: deleteDeck)
                .listRowBackground(theme.currentBackgroundColor)
            }
            .background(theme.currentBackgroundColor)
            .scrollContentBackground(.hidden)
            .navigationBarBackButtonHidden(showBackButton)
            .listRowBackground(theme.currentBackgroundColor)
            .navigationTitle("Saved Decisions")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                self.showActionSheet = false
            })
            .overlay(Group {
                if savedDecks.isEmpty {
                    ZStack {
                        theme.currentBackgroundColor.ignoresSafeArea()
                    }
                }
            })
            
            if showBackButton {
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        Group {
                            Button(action: {
                                path.removeLast(path.count)
                            }, label: {
                                Text("Done").scaledFont(name: theme.currentFont, size: 26)
                            })
                            .buttonStyle(StartViewButtonStyle(backcolor: theme.currentButtonBackgroundColor, forecolor: theme.currentBackgroundColor))
                        }.padding()
                    }
                }
            }
        }
            .scrollContentBackground(.hidden)
            .sheet(isPresented: $showActionSheet, onDismiss: {
                print("Dismiss")
            }, content: {
                ActivityViewController(activityItems: [sharedString])
            })
        return view
    }
    
    // function: delete deck from core data
    func deleteDeck(at offsets: IndexSet) {
        for index in offsets {
            let savedDeck = self.savedDecks[index]
            self.managedObjectContext.delete(savedDeck)
        }
        
        do {
            try self.managedObjectContext.save()
        } catch {
            print("error when deleting deck: \(error)")
        }
        
        // TODO
        // load most recent decision
        if savedDecks.first != nil {
            saveLastDecision(deck: savedDecks.first!, cards: savedDecks.first!.savedCardsArray)
            WidgetCenter.shared.reloadAllTimelines()
        } else {
            // do something if history is empty
            let status = "No decision made"
            let lastDecision = Decision(deckname: status, date: Date(), selectedCards: [])
            saveJSON(named: "lastDecision", object: lastDecision)
                WidgetCenter.shared.reloadAllTimelines()
        }
        
    }
    
    func generateShareString(deck: SavedDeck) -> String {
        var resultString: String
        
        resultString = "Deck: \(String(deck.deckName ?? ""))\r"
        resultString += "\r Selected cards:\r"
        for item in deck.savedCardsArray {
            resultString += "- \(String(item.cardName ?? ""))\r"
        }
        
        return resultString
    }
    
    func saveLastDecision(deck: SavedDeck, cards: [SavedCard]) {
        var selectedCards: [String] = []
        
        for card in cards {
            selectedCards.append(card.wrappedCardName)
        }
        
        let lastDecision = Decision(deckname: deck.wrappedDeckName, date: Date(), selectedCards: selectedCards)
        saveJSON(named: "lastDecision", object: lastDecision)
    }
}
