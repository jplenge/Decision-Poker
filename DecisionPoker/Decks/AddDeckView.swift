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
    @State var buttonActive: Bool = false
    @State var deckNames: [String] = []
    @State var errorString: String = ""
    
    let onComplete: (String, String) -> Void
    
    @State var finished = false
    @AppStorage("SelectedColor") private var selectedColor: Int = 0
    
    // fetch all decks from core data
    @FetchRequest(entity: Deck.entity(),
                  sortDescriptors: []
    ) var deck: FetchedResults<Deck>
    
    var body: some View {
        NavigationView {
            ZStack {
                    Form {
                        Section(header: Text("Deckname")
                            .foregroundColor(Color("AccentColor"))
                            .background(themeColor.colors[selectedColor])) {
                                TextField("New Deck Name", text: $newDeckName, axis: .vertical)
                                    .lineLimit(...3)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(themeColor.colors[selectedColor])
                                    .onChange(of: newDeckName) { text in
                                        if text.count > 0 {
                                            errorString = "A deckname can not be empty!"
                                            if deckNames.contains(text) {
                                                buttonActive = false
                                                errorString = "A deck with this name already exists!"
                                            } else {
                                                buttonActive = true
                                            }
                                        } else {
                                            buttonActive = false
                                        }
                                    }
                            }
                        
                        Section(header: Text("Comment")
                            .foregroundColor(Color("AccentColor"))
                            .background(themeColor.colors[selectedColor])) {
                                
                                TextField("Add comment here (optional)", text: $newDeckComment, axis: .vertical)
                                    .lineLimit(...6)
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(themeColor.colors[selectedColor])
                            }
                    }
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            VStack {
                                Text("Add Deck")
                                    .foregroundColor(Color("AccentColor"))
                            }
                        }
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .scrollContentBackground(.hidden)
                
                VStack {
                    Spacer()
                    Button(action: createDeck) {
                        Text("Create Deck")
                    }.buttonStyle(StartViewButtonStyle(backcolor: Color("AccentColor")
                        .opacity(buttonActive ? 1.0 : 0.5),
                                                       forecolor: themeColor.colors[selectedColor]))
                    .padding()
                    .disabled(!buttonActive)
                    
                    Text(errorString)
                        .font(.footnote)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .opacity(buttonActive ? 0 : 1)
                        .padding(.top)
                }
            }
            .background(themeColor.colors[selectedColor])
        }
        .onAppear {
            deckNames = createDeckNameArray()
        }
    }
    
    private func createDeckNameArray() -> [String] {
            return deck.map {deck in deck.deckName ?? "_error_"}
    }
    
    private func createDeck() {
        onComplete(
            newDeckName,
            newDeckComment
        )
    }
}
