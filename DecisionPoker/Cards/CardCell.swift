//
//  CardCell.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 01.07.20.
//  Copyright © 2020 Jodi Szarko. All rights reserved.
//

import SwiftUI

struct CardCell: View {
    @ObservedObject var card: Card
    
    @State var editableText: String = ""
    @State var isShowingComment = false
    @State var editableTextField: String = ""
    
    
    
    var body: some View {
        
        VStack {
            HStack {
                TextField(card.wrappedCardName.capitalized, text: $editableTextField, onCommit: saveCardTitle)
                    .multilineTextAlignment(.leading)
                    .scaledFont(name: currentFont, size: 20)
                    .padding()
                    .foregroundColor(textColor)
                    .onAppear(perform: {
                        editableTextField = card.wrappedCardName
                    })
                
                Spacer()
                
                Button(action: {
                    self.isShowingComment.toggle()
                }) {
                    Image(systemName: "info.circle")
                        .frame(width: 22, height: 22)
                        .foregroundColor(textColor)
                        .padding()
                }.buttonStyle(BorderlessButtonStyle())  // workaround so that button can be tapped
                
                Toggle(isOn: $card.cardIncluded) {
                    Text("xx")
                }
                .toggleStyle(CheckboxToggleStyle())
                .foregroundColor(textColor)
                .labelsHidden()
                
            }
            
            if isShowingComment {
                
                TextView(text: $editableText) {
                    $0.isEditable = true
                    $0.backgroundColor = backgroundcolorGreenUI
                    $0.font = UIFont(name: currentFont, size: 13)
                    $0.textColor = textColorUI
                }
                .frame(height: 80)
                .onAppear(){
                    self.editableText = card.wrappedCardcomment
                }
                .onDisappear(perform: {
                    card.cardComment = self.editableText
                })
            }
        }
    }
    
    
    
    func saveCardTitle() {
        card.cardName = editableTextField
    }
}



struct CardCell_Previews: PreviewProvider {
    static var previews: some View {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let card = Card(context: context)
        card.cardName = "Clean bike"
        card.cardComment = "urna id volutpat lacus laoreet non curabitur gravida arcu ac tortor dignissim convallis aenean et tortor at risus viverra adipiscing at in tellus integer feugiat scelerisque varius morbi enim nunc faucibus a pellentesque sit amet porttitor eget dolor morbi non arcu risus quis varius quam quisque id diam vel quam"
        card.cardsTablePosition = 99
        card.id = UUID()
        card.parentDeck = nil
        
        
        
        return CardCell(card: card)
    }
}

