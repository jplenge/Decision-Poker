//
//  SettingsUIView.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 29.10.20.
//  Copyright © 2020 Jodi Szarko. All rights reserved.
//

import SwiftUI

struct SettingsUIView: View {
    
    @State private var selectedTheme : Int = UserDefaults.standard.integer(forKey: "SelectedTheme")
    
    @State var selectedSharingMethod : Int = 0
    
    init() {
//        UINavigationBar
//            .appearance()
//            .barTintColor = theme.currentBackgroundColorUI
//        UINavigationBar
//            .appearance()
//            .tintColor = theme.currentTextColorUI
//        UINavigationBar
//            .appearance()
//            .titleTextAttributes = [.foregroundColor : theme.currentTextColorUI ?? UIColor.white, .font : UIFont(name: theme.currentFont, size: 20) as Any]
    }
    
    var body: some View {
        VStack(alignment: .center) {
            List {
                Section(header:  HStack {
                    Text("Theme")
                        .scaledFont(name: theme.currentFont, size: 16)
                        .padding()
                    Spacer()
                } .background(theme.sectionHeaderColor)
                    .listRowInsets(EdgeInsets(
                        top: 20,
                        leading: 20,
                        bottom: 0,
                        trailing: 20))
                ) {
                    ForEach(theme.themes.indices, id: \.self) { index in
                        HStack {
                            Text(theme.themes[index])
                                .scaledFont(name: theme.currentFont, size: 18)
                                .foregroundColor(theme.currentTextColor)
                            Spacer()
                            
                            Button(action: {
                                selectedTheme = index
                                theme.currentBackgroundColor = theme.colorChoices[index]
                                theme.currentBackgroundColorUI = theme.colorChoicesUI[index]
                                theme.currentFont = theme.fontChoices[index]
                                theme.unselectedRadioButtonBackgroundColor = theme.radioButtonBackgroundColorChoices[index]
                                theme.sectionHeaderColor = theme.sectionHeaderColorChoices[index]
                                theme.startImage = theme.startImageChoices[index]
                                UserDefaults.standard.set(index, forKey: "SelectedTheme")
                            }, label: {
                                ZStack {
                                    Circle()
                                        .fill(index == selectedTheme ? theme.currentButtonBackgroundColor : theme.unselectedRadioButtonBackgroundColor)
                                        .frame(width: 18, height: 18)
                                        .padding()
                                    
                                    if self.selectedTheme == index {
                                        Circle().stroke(theme.currentButtonBackgroundColor, lineWidth: 4).frame(width: 25, height: 25)
                                    }
                                }
                            })
                        }
                        .padding(
                            EdgeInsets(
                                top: 0,
                                leading: 20,
                                bottom: 0,
                                trailing: 20
                            )
                        )
                    }
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 0)
                            .background(.clear)
                            .foregroundColor(theme.currentBackgroundColor)
                            .padding(
                                EdgeInsets(
                                    top: 0,
                                    leading: 20,
                                    bottom: 0,
                                    trailing: 20
                                )
                            )
                    )
                    //.listRowBackground(theme.currentBackgroundColor)
                }
            }
            .toolbarBackground(
                theme.currentBackgroundColor,
                for: .tabBar, .navigationBar)
            .toolbarBackground(.visible, for: .tabBar, .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                            VStack {
                                Text("Settings")
                                    .font(Font(UIFont(name: theme.currentFont, size: 24)!))
                                  .foregroundColor(Color.white)
                            }
                        }
                    }
            .scrollContentBackground(.hidden)
            .listStyle(GroupedListStyle())
        }
        .background(BackgroundCardView().scaledToFit())
    }
}
