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
    @AppStorage("SelectedColor") private var selectedColor: Int = 0
    
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
                                        .foregroundColor(Color("AccentColor"))
                                        .fontDesign(.rounded)
                                    
                                    Spacer()
                                    
                                    ZStack {
                                        Circle()
                                            .fill(self.selectedIndex == index ? Color("AccentColor") : Color.gray)
                                            .frame(width: 18, height: 18)
                                        
                                        if self.selectedIndex == index {
                                            Circle().stroke(Color("AccentColor"), lineWidth: 4).frame(width: 25, height: 25)
                                        }
                                    }
                                }.foregroundColor(.black)
                            }).padding(.top)
                        }
                        .listRowBackground(theme.colors[selectedColor])
                        .listRowSeparator(.hidden)
                    }
                    .listRowBackground(theme.colors[selectedColor])
                }
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            self.pickCard()
                        }, label: {
                            Text("Pick Card")
                                .fontWeight(.bold)
                                .fontDesign(.rounded)
                        })
                        .buttonStyle(StartViewButtonStyle(backcolor: Color("AccentColor"), forecolor: theme.colors[selectedColor]))
                        Spacer()
                    }
                }.padding()
            }
            .background(theme.colors[selectedColor])
            .toolbar {
                ToolbarItem(placement: .principal) {
                            VStack {
                                Text("Replace Card")
                                    .fontWeight(.bold)
                                    .fontDesign(.rounded)
                                  .foregroundColor(Color("AccentColor"))
                            }
                        }
                    }
        }
    }
    
    private func pickCard() {
        onComplete(
            pickedCard
        )
    }
}
