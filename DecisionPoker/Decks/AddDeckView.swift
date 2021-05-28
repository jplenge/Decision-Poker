//
//  AddDeckView.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 29.06.20.
//  Copyright © 2020 Jodi Szarko. All rights reserved.
//

import SwiftUI

struct AddDeckView: View {
    
    @State var newDeckName: String = ""
    @State var newDeckComment: String = ""
    
    let onComplete: (String, String) -> Void
    
    @State var finished = false
    
    let commentString: LocalizedStringKey = "Enter comment here"
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                Form {
                    Section(header: Text("Deckname")
                                .scaledFont(name: theme.currentFont, size: 10)
                                .foregroundColor(theme.currentTextColor)
                                .background(theme.currentBackgroundColor)) {
                        TextField("New Deck Name", text: $newDeckName)
                            .multilineTextAlignment(.center)
                            .scaledFont(name: theme.currentFont, size: 18)
                            .foregroundColor(theme.currentBackgroundColor)
                    }
                    
                    Section(header: Text("Comment")
                                .scaledFont(name: theme.currentFont, size: 10)
                                .foregroundColor(theme.currentTextColor)
                                .background(theme.currentBackgroundColor)) {
                        TextView(text: $newDeckComment) {
                            $0.isEditable = true
                            $0.backgroundColor = theme.currentTextColorUI
                            $0.font = UIFont(name: theme.currentFont, size: 13)
                            $0.textColor = theme.currentBackgroundColorUI
                        }
                        .frame(height: 150)
                    }
                    .background(theme.currentTextColor)
                }
                .navigationBarTitle(Text("Add Deck"), displayMode: .inline)
                .background(theme.currentBackgroundColor)
                
                VStack {
                    Spacer()
                    Button(action: createDeck) {
                        Text("Create Deck")
                            .scaledFont(name: theme.currentFont, size: 18)
                            .font(.headline)
                    }.buttonStyle(StartViewButtonStyle(backcolor: theme.currentButtonBackgroundColor, forecolor: theme.currentBackgroundColor))
                    .padding()
                }
            }.background(theme.currentBackgroundColor)
        }
        .background(theme.currentBackgroundColor)
    }
    
    private func createDeck() {
        onComplete(
            newDeckName,
            newDeckComment
        )
    }
}
