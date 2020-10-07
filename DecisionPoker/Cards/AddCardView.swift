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
                    Section(header: Text("Cardname").scaledFont(name: currentFont, size: 10).foregroundColor(textColor).background(backgroundcolorGreen)) {
                        TextField("New cardname", text: $newCardName)
                            .multilineTextAlignment(.center)
                            .scaledFont(name: currentFont, size: 18)
                            .foregroundColor(backgroundcolorGreen)
                    }
                    
                    
                    
                    Section(header: Text("Comment").scaledFont(name: currentFont, size: 10).foregroundColor(textColor).background(backgroundcolorGreen)) {
                        TextView(text: $newCardComment) {
                            $0.isEditable = true
                            $0.backgroundColor = textColorUI
                            $0.font = UIFont(name: currentFont, size: 13)
                            $0.textColor = backgroundcolorGreenUI
                        }
                        .frame(height: 150)
                        .onAppear() {
                            /* TODO: add grey comment: Add comment here*/
                            //newDeckComment = commentString
                        }
                    }
                    .background(textColor)
                    
                }
                .navigationBarTitle(Text("New Card"), displayMode: .inline)
                .background(backgroundcolorGreen)
                
                
                VStack {
                    
                    Spacer()
                    
                    Button(action: createCard) {
                        Text("Add Card")
                            .scaledFont(name: currentFont, size: 18)
                            .font(.headline)
                    }.buttonStyle(StartViewButtonStyle(backcolor: .white, forecolor: backgroundcolorGreen))
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

