//
//  DeckCell.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 29.06.20.
//  Copyright © 2020 Jodi Szarko. All rights reserved.
//

import SwiftUI

struct DeckCell: View {
    @ObservedObject var deck: Deck
    
    @State var isShowingResultView = false
    @State var isShowingComment = false
    @State var editableText = ""
    @State var editableTextField = ""
    
    
    
    var body: some View {
        
        let view = ZStack {
            
            VStack {
                
                
                HStack {
                    TextField(deck.wrappedDeckName, text: $editableTextField, onCommit: saveTitle)
                        .multilineTextAlignment(.center)
                        .scaledFont(name: currentFont, size: 28)
                        .padding()
                        .foregroundColor(textColor)
                        .onAppear(perform: {
                            editableTextField = deck.wrappedDeckName
                        })
                    
                    
                    Button(action: {
                        self.isShowingComment.toggle()
                    }) {
                        Image(systemName: "info.circle")
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                            .padding()
                    }.buttonStyle(BorderlessButtonStyle())  // workaround so that button can be tapped
                }
                
                
                if isShowingComment {
                    
                    TextView(text: $editableText) {
                        $0.isEditable = true
                        $0.backgroundColor = backgroundcolorGreenUI
                        $0.font = UIFont(name: currentFont, size: 13)
                        $0.textColor = textColorUI       
                    }
                    .frame(height: 150)
                    .onAppear(){
                        self.editableText = deck.wrappedDeckComment
                    }
                    .onDisappear(perform: {
                        deck.deckComment = self.editableText
                    })
                }
                
                
                HStack {
                    Spacer()
                    
                    Text("Total: \(deck.childCardsCount) cards")
                        .scaledFont(name: currentFont, size: 16)
                        .foregroundColor(textColor)
                    
                    Spacer()
                    
                    Text("Active: \(deck.activeCards) cards")
                        .scaledFont(name: currentFont, size: 16)
                        .foregroundColor(textColor)
                    
                    
                    Spacer()
                }
                
                Spacer()      
                
                HStack {
                    
                    Spacer()
                    
                    Text(LocalizedStringKey("Select: \(deck.numberOfCardsToPick) cards"))
                        .scaledFont(name: currentFont, size: 16)
                        .foregroundColor(textColor)
                    
                    Spacer()
                        .frame(width: 10)
                    
                    Stepper("", onIncrement: {
                        if  self.deck.numberOfCardsToPick  < self.deck.activeCards {
                            self.deck.numberOfCardsToPick += 1
                        }
                       
                    }, onDecrement: {
                        if  self.deck.numberOfCardsToPick  > 0 {
                            self.deck.numberOfCardsToPick -= 1
                        }
                    })
                    .onAppear(){
                        if self.deck.activeCards == 0 {
                            self.deck.numberOfCardsToPick = 0
                            
                        } else if self.deck.numberOfCardsToPick > self.deck.activeCards {
                            self.deck.numberOfCardsToPick = Int16(self.deck.activeCards)
                        }
                        
                    }
                    .frame(width: 80)
                    .background(textColor)
                    .cornerRadius(10)
                    .foregroundColor(.blue)
                    
                    Spacer()
                }
                
                Spacer()
                
                VStack {
                    
                    
                    List {
                        NavigationLink(destination: DealResultSwiftUIView(selectedDeck: deck, results: deck.playGame()), isActive: $isShowingResultView) { EmptyView()}
                    }.frame(height: 0)
                    
                    Button(action: {
                        self.isShowingResultView = true
                    }){
                        Text("Deal")
                            .scaledFont(name: currentFont, size: 20)
                            .padding(.horizontal)
                    }.buttonStyle(StartViewButtonStyle(backcolor: .white, forecolor: backgroundcolorGreen))
                    
                }
                
                Spacer()
                
            }
        }
        
        return view
    }
    
    
    func updateDeckComment(){
        deck.deckComment = editableText
    }
    
    func saveTitle(){
        deck.deckName = editableTextField
    }
    
    
}



//struct DeckCell_Previews: PreviewProvider {
//    static var previews: some View {
//
//        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//
//        let deck = Deck(context: context)
//
//        deck.deckName = "Choirs"
//        deck.deckComment = "urna id volutpat lacus laoreet non curabitur gravida arcu ac tortor dignissim convallis aenean et tortor at risus viverra adipiscing at in tellus integer feugiat scelerisque varius morbi enim nunc faucibus a pellentesque sit amet porttitor eget dolor morbi non arcu risus quis varius quam quisque id diam vel quam."
//
//        return DeckCell(deck: deck, finishedEditing: <#Binding<Bool>#>)
//
//    }
//}



struct DeckCell_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
