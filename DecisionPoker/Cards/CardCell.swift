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
                    .scaledFont(name: theme.currentFont, size: 20)
                    .padding()
                    .foregroundColor(theme.currentTextColor)
                    .onAppear(perform: {
                        editableTextField = card.wrappedCardName
                    })
                    

                Spacer()

                Button(action: {
                    self.isShowingComment.toggle()
                }, label: {
                    Image(systemName: "info.circle")
                        .frame(width: 22, height: 22)
                        .foregroundColor(theme.currentButtonBackgroundColor)
                        .padding()
                })
                .buttonStyle(BorderlessButtonStyle())  // workaround so that button can be tapped

                Toggle(isOn: $card.cardIncluded) {
                   EmptyView()
                }
                .toggleStyle(CheckboxToggleStyle())
                .foregroundColor(theme.currentButtonBackgroundColor)
                .labelsHidden()
                .padding(EdgeInsets(
                    top: 0,
                    leading: 0,
                    bottom: 0,
                    trailing: 30
                ))
            }

            if isShowingComment {
                TextView(text: $editableText) {
                    $0.isEditable = true
                    $0.backgroundColor = theme.currentBackgroundColorUI
                    $0.font = UIFont(name: theme.currentFont, size: 13)
                    $0.textColor = theme.currentTextColorUI
                }
                .padding(
                    EdgeInsets(
                        top: -10,
                        leading: 10,
                        bottom: 0,
                        trailing: 10
                    )
                )
                .frame(height: 80)
                .onAppear {
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
