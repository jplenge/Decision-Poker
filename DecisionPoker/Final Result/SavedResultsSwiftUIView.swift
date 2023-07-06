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
#if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
#endif
    
    @Binding var showBackButton: Bool
    
    @Binding var path: NavigationPath
    
    @State private var showActionSheet: Bool = false
    @State private var sharedString: String = ""
    @AppStorage("SelectedColor") private var selectedColor: Int = 0
    
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
                                    .foregroundColor(Color("AccentColor"))
                                    .padding()
                                Spacer()
                            }
                            VStack(alignment: .leading) {
                                ForEach(deck.savedCardsArray, id: \.self) { card in
                                    
                                    VStack(alignment: .center) {
                                        HStack {
                                            Image(systemName: "note")
                                                .foregroundColor(Color("AccentColor"))
                                                .font(.system(size: 14))
                                            
                                            Text("\(card.wrappedCardName)")
                                                .font(.system(size: 14))
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color("AccentColor"))
                                            
                                            Spacer()
                                        }
                                        .padding(.leading)
                                    }
                                    
                                }.listRowBackground(themeColor.colors[selectedColor])
                            }
                            Spacer()
                            HStack {
                                Text("created: \(deck.creationDateFormatted)")
                                    .font(.system(size: 10))
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(Color("AccentColor"))
                                    .padding(.bottom, 8)
                                    .padding(.leading, 8)
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
                                    .buttonStyle(StartViewButtonStyle(backcolor: Color("AccentColor"),
                                                                      forecolor: themeColor.colors[selectedColor]))
                                    .padding(.bottom, 10)
                                    .padding(.trailing, 10)
                                }
                            }
                        }
                    }
                }
                .onDelete(perform: deleteDeck)
                .listRowBackground(
                    RoundedRectangle(cornerRadius: 20)
                        .background(.clear)
                        .foregroundColor(themeColor.colors[selectedColor])
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
            .toolbarBackground(
                themeColor.colors[selectedColor],
                for: .tabBar, .navigationBar)
            .toolbarBackground(.visible, for: .tabBar, .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Saved Decisions")
                            .foregroundColor(Color("AccentColor"))
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .navigationBarBackButtonHidden(showBackButton)
            .onAppear(perform: {
                self.showActionSheet = false
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
                                Text("Done")
                            })
                            .buttonStyle(StartViewButtonStyle(backcolor: Color("AccentColor"),
                                                              forecolor: themeColor.colors[selectedColor]))
                        }.padding()
                    }
                }
            }
        }.overlay {
            if savedDecks.isEmpty {
                BackgroundCardView().scaledToFit()
            }
        }
            .background {
                BackgroundCardView().scaledToFit()
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
