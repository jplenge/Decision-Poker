//
//  AddDeckView.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 29.06.20.
//  Copyright © 2020 Jodi Szarko. All rights reserved.
//

import SwiftUI

struct AddCardView: View {
        
    @State var newCardName = "New Card"
    @State var newCardComment = "Enter comment here"
    
    let onComplete: (String, String) -> Void

    @State var finished = false
    
    var body: some View {
        
        NavigationView {
            
            Form {
                Section(header: Text("Cardname")) {
                    TextField("Enter cardname", text: $newCardName)
                        .padding(10)
                        .font(Font.system(size: 15, weight: .medium, design: .rounded))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
                }
                
                Section(header: Text("Comment")) {
//                    TextView(text: $newCardComment, didFinishEditing: Binding<Bool>) {
//                        $0.isEditable = true
//                        $0.font = UIFont.systemFont(ofSize: 15, weight: .medium)
//                    }
//                    .frame(height: 50)
//                    .padding(10)
//                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
                }
                Section {
                    Button(action: createCard) {
                        Text("Add Card")
                    }
                }
            }
            .navigationBarTitle(Text("Add Card"), displayMode: .inline)
            
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

