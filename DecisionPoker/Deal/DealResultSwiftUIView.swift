//
//  DealResultSwiftUIView.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 01.07.20.
//  Copyright © 2020 Jodi Szarko. All rights reserved.
//

import SwiftUI

struct DealResultSwiftUIView: View {
    
    var selectedDeck: Deck
    @State var results: [Card]
    
    @State var isShowingFinalResultView: Bool = false
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    
    
    var body: some View {
        
        
        ZStack {
            List {
                ForEach(results.indices, id: \.self) {index  in
                    resultViewCell(card: self.results[index], index: index, selectedDeck: self.selectedDeck, results: self.$results)
                }
                .listRowBackground(Theme.currentBackgroundColor)
            }.navigationBarTitle("First Hand", displayMode: .inline)
            .onAppear(perform: {
                UITableView.appearance().backgroundColor = .clear // tableview background
                UITableViewCell.appearance().backgroundColor = .clear // cell background
            })
            .listRowBackground(Theme.currentBackgroundColor)
            
            VStack {
                
                Spacer()
                
                VStack {
                    
                    NavigationLink(destination: FinalResultSwiftUIView(selectedDeck: selectedDeck, results: results), isActive: $isShowingFinalResultView) { EmptyView() }
                    
                    Button(action: {
                        self.isShowingFinalResultView = true
                    }){
                        Text("Hold 'em!")
                            .scaledFont(name: Theme.currentFont, size: 26)
                    }.buttonStyle(StartViewButtonStyle(backcolor: Theme.currentButtonBackgroundColor, forecolor: Theme.currentBackgroundColor))
                    .padding()
                }
                
            }
        }
        .background(Theme.currentBackgroundColor)
        
    }
    
    
    
    //struct DealResultSwiftUIView_Previews: PreviewProvider {
    //    static var previews: some View {
    //        DealResultSwiftUIView()
    //    }
    //}
    
    struct resultViewCell: View {
        var card: Card
        var index: Int
        
        var selectedDeck: Deck
        
        @Binding var results: [Card]
        
        @State var cheatPickerIsPresented = false
        
        var body: some View {
            
            VStack {
                Text(card.wrappedCardName)
                    .multilineTextAlignment(.center)
                    .scaledFont(name: Theme.currentFont, size: 28)
                    .padding()
                    .foregroundColor(Theme.currentTextColor)
                
                
                HStack {
                    
                    Button(action: {
                        self.cheatPickerIsPresented = true
                    }){
                        Text("Cheat")
                            .scaledFont(name: Theme.currentFont, size: 14)
                    }.buttonStyle(StartViewButtonStyle(backcolor: Theme.currentButtonBackgroundColor, forecolor: Theme.currentBackgroundColor))
                    
                    Spacer()
                    
                    Button(action: {
                        self.results[self.index] = self.selectedDeck.repickCard(selectedCards: self.results, current: self.results[self.index])
                    }){
                        Text("Redraw")
                            .scaledFont(name: Theme.currentFont, size: 14)
                    }.buttonStyle(StartViewButtonStyle(backcolor: Theme.currentButtonBackgroundColor, forecolor: Theme.currentBackgroundColor))
                }
            }.sheet(isPresented: $cheatPickerIsPresented) {
                CheatPickerView(deck: self.selectedDeck, pickedCard: self.results[self.index], selected: self.index) {pickedCard in
                    self.results[self.index]  = pickedCard
                    self.cheatPickerIsPresented = false
                }
            }
        }
        
    }
}


