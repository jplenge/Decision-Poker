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
        
        let view = ZStack {
            
            VStack(alignment: .leading, spacing: 20) {
                
                HStack {
                    Spacer()
                    Text("Replace card with").scaledFont(name: currentFont, size: 26).multilineTextAlignment(.center).padding(.top).foregroundColor(textColor)
                    Spacer()
                }
                                
                List {
                    ForEach(data.indices, id: \.self) { index  in
                        
                        Button(action: {
                            self.selected = index
                            self.pickedCard = data[index]
                        }) {
                            HStack{
                                Text(data[index].wrappedCardName.capitalized)
                                    .scaledFont(name: currentFont, size: 26)
                                    .foregroundColor(textColor)
                                    
                                Spacer()
                                ZStack{
                                    Circle().fill(self.selected == index ? textColor : Color.black.opacity(0.3)).frame(width: 18, height: 18)
                                    
                                    if self.selected == index{
                                        Circle().stroke(textColor, lineWidth: 4).frame(width: 25, height: 25)
                                    }
                                }
                            }.foregroundColor(.black)
                        }.padding(.top)
                    }
                    .listRowBackground(backgroundcolorGreen)
                }
                .listRowBackground(backgroundcolorGreen)
            }
            
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                                   self.pickCard()
                               }) {
                                   Text("Pick Card").scaledFont(name: currentFont, size: 26)
                    
                    }.buttonStyle(StartViewButtonStyle(backcolor: .white, forecolor: backgroundcolorGreen))
                               
                               
                    
                    Spacer()
                }
            }.padding()
            

            
        }
        .background(backgroundcolorGreen)
        
        return view
    }
    
    
    
    private func pickCard() {
        onComplete (
            pickedCard
        )
    }
    
}

