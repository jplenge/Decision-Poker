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
    
    
    @Environment(\.managedObjectContext) var managedObjectContext


    @FetchRequest(entity: SavedDeck.entity(), sortDescriptors: []) var savedDecks: FetchedResults<SavedDeck>
    
    var body: some View {
        
    NavigationView {
                VStack {
                          List {
                              ForEach(savedDecks, id: \.id) { savedDeck in
                                  Text(savedDeck.deckName ?? "Unknown")
                              }
                          }
                      }
         .navigationBarTitle(Text("Saved Results"))
        }
    }
}


struct SavedResultsSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
               
        return SavedResultsSwiftUIView().environment(\.managedObjectContext, context)
        
        
    }
}




