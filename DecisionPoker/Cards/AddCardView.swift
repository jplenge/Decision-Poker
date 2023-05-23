//
//  AddDeckView.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 29.06.20.
//  Copyright © 2020 Jodi Szarko. All rights reserved.
//

import SwiftUI

struct AddCardView: View {
    
    @State var newCardName = ""
    @State var newCardComment = ""
    
    let onComplete: (String, String) -> Void
    
    @State var finished = false
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                Form {
                    Section(header: Text("Cardname")
                                .scaledFont(name: theme.currentFont, size: 10)
                                .foregroundColor(theme.currentTextColor)
                                .background(theme.currentBackgroundColor)) {
                        TextField("New Cardname", text: $newCardName)
                            .multilineTextAlignment(.center)
                            .scaledFont(name: theme.currentFont, size: 18)
                            .foregroundColor(theme.currentBackgroundColor)
                    }
                    
                    Section(header: Text("Comment")
                                .scaledFont(name: theme.currentFont, size: 10)
                                .foregroundColor(theme.currentTextColor)
                                .background(theme.currentBackgroundColor)) {
                        TextView(text: $newCardComment) {
                            $0.isEditable = true
                            $0.backgroundColor = theme.currentTextColorUI
                            $0.font = UIFont(name: theme.currentFont, size: 13)
                            $0.textColor = theme.currentBackgroundColorUI
                        }
                        .frame(height: 150)
                        .onAppear {
                        }
                    }
                }
                .navigationTitle("New Card")
                .navigationBarTitleDisplayMode(.inline)
                .background(theme.currentBackgroundColor)
                .scrollContentBackground(.hidden)
                
                VStack {
                    Spacer()
                    Button(action: createCard) {
                        Text("Add Card")
                            .scaledFont(name: theme.currentFont, size: 18)
                            .font(.headline)
                    }.buttonStyle(StartViewButtonStyle(backcolor: theme.currentButtonBackgroundColor, forecolor: theme.currentBackgroundColor))
                    .padding()
                }
                
            }
        }
    }
    
    private func createCard() {
        onComplete(
            newCardName,
            newCardComment
        )
        
    }
}
