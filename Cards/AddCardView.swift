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
    
    @AppStorage("SelectedColor") private var selectedColor: Int = 0
    
    @State var finished: Bool = false
    @State var buttonActive: Bool = false
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                Form {
                    Section(header: Text("Cardname")
                        .foregroundColor(Color.white)
                        .background(themeColor.colors[selectedColor])) {
                            
                            TextField("New Card Name", text: $newCardName, axis: .vertical)
                                .lineLimit(...3)
                                .multilineTextAlignment(.center)
                                .foregroundColor(themeColor.colors[selectedColor])
                                .onChange(of: newCardName) { text in
                                    if text.count > 0 {
                                        buttonActive = true
                                    } else {
                                        buttonActive = false
                                    }
                                }
                        }
                    
                    Section(header: Text("Comment")
                        .foregroundColor(Color("AccentColor"))
                        .background(themeColor.colors[selectedColor])) {
                            TextField("Add comment here (optional)", text: $newCardComment, axis: .vertical)
                                .lineLimit(...6)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(themeColor.colors[selectedColor])
                        }
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        VStack {
                            Text("New Card")
                                .foregroundColor(Color("AccentColor"))
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .scrollContentBackground(.hidden)
                
                VStack {
                    Spacer()
                    Button(action: createCard) {
                        Text("Add Card")
                    }.buttonStyle(StartViewButtonStyle(backcolor: Color("AccentColor")
                        .opacity(buttonActive ? 1.0 : 0.5),
                                                       forecolor: themeColor.colors[selectedColor]))
                    .padding()
                    .disabled(!buttonActive)
                    .buttonStyle(StartViewButtonStyle(backcolor: Color("AccentColor"), forecolor: themeColor.colors[selectedColor]))
                    .padding()
                }
            }
            .background(themeColor.colors[selectedColor])
        }
    }
    
    private func createCard() {
        onComplete(
            newCardName,
            newCardComment
        )
    }
}
