//
//  DealResultSwiftUIView.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 01.07.20.
//  Copyright © 2020 Jodi Szarko. All rights reserved.
//

import SwiftUI

struct DealResultSwiftUIView: View {
    @ObservedObject var viewModel: ViewModel
    @Binding var path: NavigationPath
    // NOTE: With @AppStorage the button or navigationDestination(isPresented  is not working, therefore userdefaults
    @State var selectedColor: Int = UserDefaults.standard.integer(forKey: "SelectedColor")
    @State private var showNextView: Bool = false
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        ZStack {
            List {
                HStack(alignment: .center) {
                    Spacer()
                    Text(viewModel.selectedDeck.wrappedDeckName)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(("AccentColor")))
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding()
                    Spacer()
                }.listRowBackground(
                    RoundedRectangle(cornerRadius: 20)
                        .background(.clear)
                        .foregroundColor(theme.colors[selectedColor])
                        .padding(
                            EdgeInsets(
                                top: 5,
                                leading: 0,
                                bottom: 5,
                                trailing: 0
                            )
                        )
                )
                
                    ForEach(viewModel.gameResult.indices, id: \.self) {index  in
                        ResultViewCell(index: index, viewModel: viewModel)
                    }
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 20)
                            .background(.clear)
                            .foregroundColor(theme.colors[selectedColor])
                            .padding(
                                EdgeInsets(
                                    top: 5,
                                    leading: 10,
                                    bottom: 5,
                                    trailing: 10
                                )
                            )
                    )
                    .listRowSeparator(.hidden)
            }
            
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("First Hand")
                            .fontWeight(.bold)
                            .fontDesign(.rounded)
                            .foregroundColor(theme.colors[selectedColor])
                    }
                }
            }
            .toolbarBackground(.visible, for: .tabBar, .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .scrollContentBackground(.hidden)
            .onAppear {
                showNextView = false
            }
            
            VStack {
                Spacer()
                VStack {
                    Button(action: {
                        showNextView = true
                    }, label: {
                        Text("Hold 'em!")
                            .fontWeight(.bold)
                            .fontDesign(.rounded)
                            .foregroundColor(theme.colors[selectedColor])
                    })
                    .accessibilityIdentifier("hold.btn")
                    .buttonStyle(StartViewButtonStyle(backcolor: Color("AccentColor"),
                                                        forecolor: theme.colors[selectedColor]))
                    .padding()
                    .navigationDestination(isPresented: $showNextView,
                                           destination: { FinalResultSwiftUIView(path: $path,
                                                                                 viewModel: viewModel)})
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .background(BackgroundCardView().scaledToFit())
    }
}

struct ResultViewCell: View {
    @State var index: Int
    @ObservedObject var viewModel: ViewModel
    @State var cheatPickerIsPresented = false
    @AppStorage("SelectedColor") private var selectedColor: Int = 0
    
    var body: some View {
        
        VStack {
            Text(viewModel.gameResult[index].wrappedCardName)
                .multilineTextAlignment(.leading)
                .foregroundColor(Color("AccentColor"))
                .fontDesign(.rounded)
                .font(.body)
                .padding()
            HStack {
                
                Button(action: {
                    self.cheatPickerIsPresented = true
                }, label: {
                    Text("Cheat")
                        .font(.footnote)
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                }).buttonStyle(StartViewButtonStyle(backcolor: Color("AccentColor"), forecolor: theme.colors[selectedColor]))
                    .padding(.leading, 20)
                    .padding(.bottom, 10)
                
                Spacer()
                
                Button(action: {
                    viewModel.redrawCard(index: self.index)
                }, label: {
                    Text("Redraw")
                        .font(.footnote)
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                }).buttonStyle(StartViewButtonStyle(backcolor: Color("AccentColor"), forecolor: theme.colors[selectedColor]))
                    .padding(.trailing, 20)
                    .padding(.bottom, 10)
            }
        }.sheet(isPresented: $cheatPickerIsPresented) {
            let possibleCards = updateSelection(possibleCards: viewModel.selectedDeck.childCardsActiveArray,
                                                selectedCards: viewModel.gameResult,
                                                currentCard: viewModel.gameResult[self.index])
            let firstIndex = possibleCards.firstIndex(of: viewModel.gameResult[self.index])
            
            CheatPickerView(pickedCard: viewModel.gameResult[self.index],
                            selectedIndex: firstIndex ?? 0,
                            possibleCards: possibleCards,
                            onComplete: { pickedCard in
                viewModel.gameResult[self.index]  = pickedCard
                self.cheatPickerIsPresented = false
            })
        }
    }
    
    private func updateSelection(possibleCards: [Card], selectedCards: [Card], currentCard: Card) -> [Card] {
        
        var filtered: [Card] = []
        
        for index in 0..<possibleCards.count {
            if !selectedCards.contains(possibleCards[index]) || possibleCards[index] == currentCard {
                filtered.append(possibleCards[index])
            }
        }
        return filtered
    }
}
