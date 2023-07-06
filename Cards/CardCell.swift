//
//  CardCell.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 01.07.20.
//  Copyright © 2020 Jodi Szarko. All rights reserved.
//

import SwiftUI

struct CardCell: View {
    @ObservedObject var card: Card
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var editableText: String = ""
    @State var isShowingComment = false
    @State var editableTextField: String = ""
    @AppStorage("SelectedColor") private var selectedColor: Int = 0
    
    var body: some View {
        
        VStack {
            HStack {
                TextField(card.wrappedCardName, text: $editableTextField, axis: .vertical)
                .lineLimit(...3)
                .multilineTextAlignment(.leading)
                .foregroundColor(Color("AccentColor"))
                .font(.subheadline)
                .onAppear {
                    editableTextField = card.wrappedCardName
                }
                .onSubmit {
                    saveCardTitle()
                }
                .padding(.leading, 15)
                
                Spacer()
                
                Button(action: {
                    self.isShowingComment.toggle()
                }, label: {
                    Image(systemName: "info.circle")
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color("AccentColor"))
                        .padding(
                            EdgeInsets(
                                top: 10,
                                leading: 0,
                                bottom: 10,
                                trailing: 0
                            )
                        )
                })
                .buttonStyle(BorderlessButtonStyle())  // workaround so that button can be tapped
                
                Toggle(isOn: $card.cardIncluded) {
                    EmptyView()
                }
                .toggleStyle(CheckboxToggleStyle())
                .foregroundColor(Color("AccentColor"))
                .labelsHidden()
                .padding(EdgeInsets(
                    top: 0,
                    leading: 0,
                    bottom: 0,
                    trailing: 30
                ))
            }
            
            if isShowingComment {
                TextView(text: $editableText) {
                    $0.isEditable = true
                    $0.backgroundColor = UIColor(themeColor.colors[selectedColor])
                    $0.textColor = UIColor(Color("AccentColor"))
                }
                .padding(
                    EdgeInsets(
                        top: -10,
                        leading: 10,
                        bottom: 0,
                        trailing: 10
                    )
                )
                .frame(height: 80)
                .onAppear {
                    self.editableText = card.wrappedCardcomment
                }
                .onDisappear(perform: {
                    card.cardComment = self.editableText
                })
            }
        }
    }
    
    func saveCardTitle() {
        card.cardName = self.card.wrappedCardName
        
        do {
            try self.managedObjectContext.save()
        } catch {
            print(error)
        }
    }
}
