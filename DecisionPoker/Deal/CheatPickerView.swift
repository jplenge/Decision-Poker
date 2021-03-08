//
//  CheatPickerView.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 01.07.20.
//  Copyright © 2020 Jodi Szarko. All rights reserved.
//

import SwiftUI

struct CheatPickerView: View {
    @State var pickedCard: Card
    @State var selectedIndex: Int
    let possibleCards: [Card] 
    let onComplete: (Card) -> Void
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    List {
                        ForEach(possibleCards.indices, id: \.self) { index  in
                            
                            Button(action: {
                                self.selectedIndex = index
                                self.pickedCard = possibleCards[index]
                            }) {
                                HStack{
                                    Text(possibleCards[index].wrappedCardName)
                                        .scaledFont(name: Theme.currentFont, size: 26)
                                        .foregroundColor(Theme.currentTextColor)
                                    
                                    Spacer()
                                    
                                    ZStack{
                                        Circle().fill(self.selectedIndex == index ? Theme.currentButtonBackgroundColor : Theme.unselectedRadioButtonBackgroundColor).frame(width: 18, height: 18)
                                        
                                        if self.selectedIndex == index {
                                            Circle().stroke(Theme.currentButtonBackgroundColor, lineWidth: 4).frame(width: 25, height: 25)
                                        }
                                    }
                                }.foregroundColor(.black)
                            }.padding(.top)
                        }
                        .listRowBackground(Theme.currentBackgroundColor)
                    }
                    .listRowBackground(Theme.currentBackgroundColor)
                }
                
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            self.pickCard()
                        }) {
                            Text("Pick Card").scaledFont(name: Theme.currentFont, size: 26)
                        }.buttonStyle(StartViewButtonStyle(backcolor: Theme.currentButtonBackgroundColor, forecolor: Theme.currentBackgroundColor))
                        Spacer()
                    }
                }.padding()
                
                
                
            }
            .background(Theme.currentBackgroundColor)
            .navigationBarTitle("Replace Card", displayMode: .inline)
        }
        
    }
    
    
    private func pickCard() {
        onComplete (
            pickedCard
        )
    }
    
}

