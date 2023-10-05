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
    @FocusState var isFocused : Bool
    
    @AppStorage("SelectedColor") private var selectedColor: Int = 0
    
    // fetch all decks from core data
    @FetchRequest(entity: Deck.entity(),
                  sortDescriptors: []
    ) var deck: FetchedResults<Deck>
    
    var body: some View {
        NavigationView {
            ZStack {
                    Form {
                        Section(header: Text("deck.add.name.section.header")
                            .foregroundColor(Color("AccentColor"))
                            .background(theme.colors[selectedColor])) {
                                TextField("deck.add.textfield.name", text: $newDeckName, axis: .vertical)
                                    .lineLimit(...3)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(theme.colors[selectedColor])
                                    .fontDesign(.rounded)
                                    .focused($isFocused)
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
                        
                        Section(header: Text("deck.add.comment.section.header")
                            .foregroundColor(Color("AccentColor"))
                            .background(theme.colors[selectedColor])) {
                                
                                TextField("deck.add.textfield.comment", text: $newDeckComment, axis: .vertical)
                                    .lineLimit(...6)
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(theme.colors[selectedColor])
                                    .fontDesign(.rounded)
                                    .focused($isFocused)
                            }
                    }
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            VStack {
                                Text("deck.add.title")
                                    .fontWeight(.bold)
                                    .fontDesign(.rounded)
                                    .foregroundColor(Color("AccentColor"))
                            }
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .keyboard) {
                                    Button("deck.add.keyboard.done.label") {
                                        isFocused = false
                                    }
                                    .foregroundColor(.blue)
                                    .fontWeight(.bold)
                                }
                            }
                    .navigationBarTitleDisplayMode(.inline)
                    .scrollContentBackground(.hidden)
                
                VStack {
                    Spacer()
                    Button(action: createDeck) {
                        Text("deck.create.button.label")
                            .fontWeight(.bold)
                            .fontDesign(.rounded)
                    }.buttonStyle(StartViewButtonStyle(backcolor: Color("AccentColor")
                        .opacity(buttonActive ? 1.0 : 0.5),
                                                       forecolor: theme.colors[selectedColor]))
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
            .background(theme.colors[selectedColor])
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
