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
                    Section(header: Text("Deckname").scaledFont(name: Theme.currentFont, size: 10).foregroundColor(Theme.currentTextColor).background(Theme.currentBackgroundColor)) {
                        TextField("New Deck Name", text: $newDeckName)
                            .multilineTextAlignment(.center)
                            .scaledFont(name: Theme.currentFont, size: 18)
                            .foregroundColor(Theme.currentBackgroundColor)
                    }
                    
                    Section(header: Text("Comment").scaledFont(name: Theme.currentFont, size: 10).foregroundColor(Theme.currentTextColor).background(Theme.currentBackgroundColor)) {
                        TextView(text: $newDeckComment) {
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
                .navigationBarTitle(Text("Add Deck"), displayMode: .inline)
                .background(Theme.currentBackgroundColor)
                
                
                VStack {
                    
                    Spacer()
                    
                    Button(action: createDeck) {
                        Text("Create Deck")
                            .scaledFont(name: Theme.currentFont, size: 18)
                            .font(.headline)
                    }.buttonStyle(StartViewButtonStyle(backcolor: Theme.currentButtonBackgroundColor, forecolor: Theme.currentBackgroundColor))
                    .padding()
                }
            }.background(Theme.currentBackgroundColor)
        }
        .background(Theme.currentBackgroundColor)
    }
    
    
    private func createDeck() {
        onComplete (
            newDeckName,
            newDeckComment
        )
    }
    
}


//struct AddDeckView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddDeckView()
//    }
//}

struct AddDeckView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
