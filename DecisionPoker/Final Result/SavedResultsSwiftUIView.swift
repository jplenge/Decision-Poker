//
//  SavedResultsSwiftUIView.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 24.06.20.
//  Copyright © 2020 Jodi Szarko. All rights reserved.
//

import SwiftUI
import CoreData

struct  SavedResultsSwiftUIView: View {
    
    @Binding var showBackButton: Bool
    
    // required for going home to first screen
    @EnvironmentObject var appState: AppState
    
    @State private var showActionSheet: Bool = false
    
    @State private var sharedString: String = ""
    
    init(showBackButton: Binding<Bool>) {
        
        self._showBackButton = showBackButton

        UITableView.appearance().allowsSelection = true
        UITableViewCell.appearance().selectionStyle = .none
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
                                    .scaledFont(name: Theme.currentFont, size: 22)
                                    .foregroundColor(Theme.currentTextColor)
                                    .padding()
                                
                                Spacer()
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .leading) {
                                ForEach(deck.savedCardsArray,  id: \.self) { card in
                                    Text("• \(card.wrappedCardName)")
                                        .multilineTextAlignment(.leading)
                                        .scaledFont(name: Theme.currentFont, size: 16)
                                        .foregroundColor(Theme.currentTextColor)
                                }.listRowBackground(Theme.currentBackgroundColor)
                            }
                            
                            Spacer()
                            
                            HStack {
                                Text("created: \(deck.creationDateFormatted)")
                                    .multilineTextAlignment(.leading)
                                    .scaledFont(name: Theme.currentFont, size: 8)
                                    .foregroundColor(Theme.currentTextColor)
                                
                                Spacer()
                                
                            }
                            
                        }
                        
            
                        HStack {
                            
                            Spacer()
                            
                            VStack {
                                
                                Spacer()
                                
                                Group {
                                    //NavigationLink(destination: FinalResultSwiftUIView(selectedDeck: selectedDeck, results: results), isActive: $isShowingSavedResults) { EmptyView() }
                                    Button(action: {
                                        self.sharedString  = generateShareString(deck: deck)
                                        self.showActionSheet = true
                                    }){
                                        Image(systemName: "square.and.arrow.up")
                                            .imageScale(.small)
                                    }.buttonStyle(StartViewButtonStyleCircle(backcolor: Theme.currentButtonBackgroundColor, forecolor: Theme.currentBackgroundColor))
                                }
                                
                            }
                        }
                        
                        
                    }
               
                }
                .onDelete(perform: deleteDeck)
                .listRowBackground(Theme.currentBackgroundColor)
            }.listRowBackground(Theme.currentBackgroundColor)
            .navigationBarTitle("Saved Decisions", displayMode: .inline)
            .navigationBarHidden(false)
            .onAppear(perform: {
                UITableView.appearance().backgroundColor = .clear // tableview background
                UITableViewCell.appearance().backgroundColor = .clear // cell background
                self.showActionSheet = false
            })
            
            .background(Theme.currentBackgroundColor)
            
            if showBackButton {
                HStack {
                    
                    Spacer()
                    
                    VStack {
                        
                        Spacer()
                        
                        Group {
                            Button(action: {
                                self.appState.moveToRoot = true
                            }){
                                Text("Done").scaledFont(name: Theme.currentFont, size: 26)
                            }.buttonStyle(StartViewButtonStyle(backcolor: Theme.currentButtonBackgroundColor, forecolor: Theme.currentBackgroundColor))
                        }.padding()
                    }
                }
            }
            
        }
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
    
    
    
}




struct SavedResultsSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        return SavedResultsSwiftUIView(showBackButton: .constant(true)).environment(\.managedObjectContext, context)
    }
}




