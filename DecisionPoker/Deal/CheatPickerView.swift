//
//  CheatPickerView.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 01.07.20.
//  Copyright © 2020 Jodi Szarko. All rights reserved.
//

import SwiftUI

struct CheatPickerView: View {
    
    var  deck: Deck = Deck()
    
    @State var pickedCard: Card
    @State var selected : Int = 0
    
    let onComplete: (Card) -> Void
    
    
    var body: some View {
        
        let data = deck.childCardsArray
        
        NavigationView {
        
        ZStack {
            
            VStack(alignment: .leading, spacing: 20) {
                
                List {
                    ForEach(data.indices, id: \.self) { index  in
                        
                        Button(action: {
                            self.selected = index
                            self.pickedCard = data[index]
                        }) {
                            HStack{
                                Text(data[index].wrappedCardName.capitalized)
                                    .scaledFont(name: Theme.currentFont, size: 26)
                                    .foregroundColor(Theme.currentTextColor)
                                
                                Spacer()
                                ZStack{
                                    Circle().fill(self.selected == index ? Theme.currentButtonBackgroundColor : Theme.unselectedRadioButtonBackgroundColor).frame(width: 18, height: 18)
                                    
                                    if self.selected == index{
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
//        .background(NavigationConfigurator { nc in
//            nc.navigationBar.barTintColor = Theme.currentBackgroundColorUI
//            nc.navigationBar.titleTextAttributes = [.foregroundColor : Theme.currentTextColorUI, .font : UIFont(name: Theme.currentFont, size: 20) as Any]
//            nc.navigationBar.tintColor = Theme.currentTextColorUI
//        })
        .navigationBarTitle("Replace Card", displayMode: .inline)
    }
        
    }
    
    
    
    private func pickCard() {
        onComplete (
            pickedCard
        )
    }
    
}

