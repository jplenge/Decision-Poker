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
                    Section(header: Text("Cardname").scaledFont(name: Theme.currentFont, size: 10).foregroundColor(Theme.currentTextColor).background(Theme.currentBackgroundColor)) {
                        TextField("New cardname", text: $newCardName)
                            .multilineTextAlignment(.center)
                            .scaledFont(name: Theme.currentFont, size: 18)
                            .foregroundColor(Theme.currentBackgroundColor)
                    }
                    
                    
                    
                    Section(header: Text("Comment").scaledFont(name: Theme.currentFont, size: 10).foregroundColor(Theme.currentTextColor).background(Theme.currentBackgroundColor)) {
                        TextView(text: $newCardComment) {
                            $0.isEditable = true
                            $0.backgroundColor = Theme.currentTextColorUI
                            $0.font = UIFont(name: Theme.currentFont, size: 13)
                            $0.textColor = Theme.currentBackgroundColorUI
                        }
                        .frame(height: 150)
                        .onAppear() {
                            /* TODO: add grey comment: Add comment here*/
                            //newDeckComment = commentString
                        }
                    }
                    .background(Theme.currentTextColor)
                    
                }
                .navigationBarTitle(Text("New Card"), displayMode: .inline)
                .background(Theme.currentBackgroundColor)
                
                
                VStack {
                    
                    Spacer()
                    
                    Button(action: createCard) {
                        Text("Add Card")
                            .scaledFont(name: Theme.currentFont, size: 18)
                            .font(.headline)
                    }.buttonStyle(StartViewButtonStyle(backcolor: Theme.currentButtonBackgroundColor, forecolor: Theme.currentBackgroundColor))
                    .padding()
                }
                
            }
        }
    }
    
    private func createCard() {
        onComplete (
            newCardName,
            newCardComment
        )
        
    }
    
}





//struct AddDeckView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddDeckView()
//    }
//}

