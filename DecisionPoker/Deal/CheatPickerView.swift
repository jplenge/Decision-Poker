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
                            }, label: {
                                HStack {
                                    Text(possibleCards[index].wrappedCardName)
                                        .scaledFont(name: theme.currentFont, size: 26)
                                        .foregroundColor(theme.currentTextColor)
                                    
                                    Spacer()
                                    
                                    ZStack {
                                        Circle()
                                            .fill(self.selectedIndex == index ? theme.currentButtonBackgroundColor : theme.unselectedRadioButtonBackgroundColor)
                                            .frame(width: 18, height: 18)
                                        
                                        if self.selectedIndex == index {
                                            Circle().stroke(theme.currentButtonBackgroundColor, lineWidth: 4).frame(width: 25, height: 25)
                                        }
                                    }
                                }.foregroundColor(.black)
                            }).padding(.top)
                        }
                        .listRowBackground(theme.currentBackgroundColor)
                    }
                    .listRowBackground(theme.currentBackgroundColor)
                }
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            self.pickCard()
                        }, label: {
                            Text("Pick Card")
                                .scaledFont(name: theme.currentFont, size: 26)
                        })
                        .buttonStyle(StartViewButtonStyle(backcolor: theme.currentButtonBackgroundColor, forecolor: theme.currentBackgroundColor))
                        Spacer()
                    }
                    
                }.padding()
            }
            .background(theme.currentBackgroundColor)
            .navigationBarTitle("Replace Card", displayMode: .inline)
        }
    }
    
    private func pickCard() {
        onComplete(
            pickedCard
        )
    }
}
