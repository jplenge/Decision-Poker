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
    
    
    init(showBackButton: Binding<Bool>) {
        
        self._showBackButton = showBackButton
        
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: currentFont, size: 20)!, .foregroundColor: backgroundcolorGreenUI]
        UINavigationBar.appearance().tintColor = backgroundcolorGreenUI
        
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
                
                ForEach(savedDecks.indices) { index in
                    
                    VStack {
                        
                        HStack {
                            Spacer()
                            Text(self.savedDecks[index].wrappedDeckName)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .scaledFont(name: currentFont, size: 22)
                                .foregroundColor(textColor)
                                .padding()
                            
                            Spacer()
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            ForEach(self.savedDecks[index].savedCardsArray,  id: \.self) { card in
                                Text("• \(card.wrappedCardName)")
                                    .multilineTextAlignment(.leading)
                                    .scaledFont(name: currentFont, size: 16)
                                    .foregroundColor(textColor)
                            }.listRowBackground(backgroundcolorGreen)
                        }
                        
                        Spacer()
                        
                        HStack {
                            Text("created: \(self.savedDecks[index].creationDateFormatted)")
                                .multilineTextAlignment(.leading)
                                .scaledFont(name: currentFont, size: 8)
                                .foregroundColor(textColor)
                            
                            Spacer()
                            
                        }
                        
                    }
                }
                .onDelete(perform: deleteDeck)
                .listRowBackground(backgroundcolorGreen)
            }.listRowBackground(backgroundcolorGreen)
            .navigationBarTitle("Saved Decisions", displayMode: .inline)
            .navigationBarHidden(false)
            .onAppear(perform: {
                UITableView.appearance().backgroundColor = .clear // tableview background
                UITableViewCell.appearance().backgroundColor = .clear // cell background
            })
            .background(backgroundcolorGreen)
            
            
            
            if showBackButton {
                HStack {
                    
                    Spacer()
                    
                    VStack {
                        
                        Spacer()
                        
                        Group {
                            Button(action: {
                                self.appState.moveToRoot = true
                            }){
                                Text("Start over").scaledFont(name: currentFont, size: 26)
                            }.buttonStyle(StartViewButtonStyle(backcolor: .white, forecolor: backgroundcolorGreen))
                        }.padding()
                    }
                }
            }
        }
        
        return view
    }
    
    
    
    
    // function: delete deck from core data
    func deleteDeck(at offsets: IndexSet) {
        if let index = offsets.first {
            print("delete at \(index)")
            let savedDeck = self.savedDecks[index]
            self.managedObjectContext.delete(savedDeck)
        }
        
        
        do {
            try self.managedObjectContext.save()
        } catch {
            print("error when deleting deck: \(error)")
        }
    }
    
}




struct SavedResultsSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        return SavedResultsSwiftUIView(showBackButton: .constant(true)).environment(\.managedObjectContext, context)
    }
}




