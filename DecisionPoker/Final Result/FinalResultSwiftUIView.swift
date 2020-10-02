//
//  FinalResultSwiftUIView.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 02.07.20.
//  Copyright © 2020 Jodi Szarko. All rights reserved.
//

import SwiftUI
import CoreData

struct FinalResultSwiftUIView: View {
    
    var selectedDeck: Deck
    var results: [Card]
    
    @State var isShowingSavedResults: Bool = false
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    
    var body: some View {
        
        let view = ZStack {
            
            VStack {
                Image("Card Hand Image")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                
                VStack {
                    Text("Here is your Result for")
                        .scaledFont(name: currentFont, size: 18)
                        .foregroundColor(textColor)
                    
                    Text(selectedDeck.wrappedDeckName)
                        .scaledFont(name: currentFont, size: 22)
                        .foregroundColor(textColor)
                        .padding()
                }
                
                
                List {
                    ForEach(self.results.indices) { index in
                        HStack {
                            Spacer()
                        Text(self.results[index].wrappedCardName)
                            .multilineTextAlignment(.center)
                            .scaledFont(name: currentFont, size: 18)
                            .foregroundColor(textColor)
                            
                            Spacer()
                        }
                    }
                    .listRowBackground(backgroundcolorGreen)
                }
                .listRowBackground(backgroundcolorGreen)
            }
            .background(backgroundcolorGreen)
            
            
            
            HStack {
                
                Spacer()
                
                VStack {
                    
                    Spacer()
                    
                    Group {
                        NavigationLink(destination: SavedResultsSwiftUIView(showBackButton: .constant(true)), isActive: $isShowingSavedResults) { EmptyView() }
                            .isDetailLink(false)
                        Button(action: {
                            self.saveResults(deck: self.selectedDeck, cards: self.results)
                            self.isShowingSavedResults = true
                        }){
                            Text("Save").scaledFont(name: currentFont, size: 26)
                            
                        }.buttonStyle(StartViewButtonStyle(backcolor: .white, forecolor: backgroundcolorGreen))
                        
                    }.padding()
                }
            }
            
            
            HStack {
                
                VStack {
                    
                    Spacer()
                    
                    Group {
                        NavigationLink(destination: FinalResultSwiftUIView(selectedDeck: selectedDeck, results: results), isActive: $isShowingSavedResults) { EmptyView() }
                        Button(action: {
                            self.isShowingSavedResults = true
                        }){
                            Image(systemName: "square.and.arrow.up")
                                .imageScale(.large)
                        }.buttonStyle(StartViewButtonStyle(backcolor: .white, forecolor: backgroundcolorGreen))
                    }.padding()
                }
                
                Spacer()
                
            }
            
        }
        
        return view
        
        
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



//struct FinalResultSwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        FinalResultSwiftUIView()
//    }
//}

struct FinalResultSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
