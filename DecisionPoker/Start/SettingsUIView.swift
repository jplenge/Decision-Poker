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
    
    // required for going home to first screen
    @EnvironmentObject var appState: AppState
    
    init() {
        UINavigationBar
            .appearance()
            .barTintColor = theme.currentBackgroundColorUI
        UINavigationBar
            .appearance()
            .tintColor = theme.currentTextColorUI
        UINavigationBar
            .appearance()
            .titleTextAttributes = [.foregroundColor : theme.currentTextColorUI ?? UIColor.white, .font : UIFont(name: theme.currentFont, size: 20) as Any]
        }
    
    var body: some View {
        
        VStack(alignment: .center) {
            List {
                Section(header:  HStack {
                    Text("Theme")
                        .scaledFont(name: theme.currentFont, size: 16)
                        .foregroundColor(theme.sectionHeaderColor)
                        .padding()
                    
                    Spacer()
                }
                .background(Color.white)
                .listRowInsets(EdgeInsets(
                                top: 0,
                                leading: 0,
                                bottom: 0,
                                trailing: 0))
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
                                self.appState.moveToRoot = true
                            }) {
                                
                                ZStack {
                                    Circle()
                                        .fill(index == selectedTheme ? theme.currentButtonBackgroundColor : theme.unselectedRadioButtonBackgroundColor)
                                        .frame(width: 18, height: 18)
                                        .padding()
                                    
                                    if self.selectedTheme == index {
                                        Circle().stroke(theme.currentButtonBackgroundColor, lineWidth: 4).frame(width: 25, height: 25)
                                    }
                                }
                            }
                        }
                    }
                    .listRowBackground(theme.currentBackgroundColor)
                }
            }
            .onAppear {
                UITableView.appearance().backgroundColor = .clear
                UITableViewCell.appearance().backgroundColor = .clear
            }
            .navigationBarTitle("Settings", displayMode: .inline)
            .listStyle(GroupedListStyle())
            
            Spacer()
        }
        .background(theme.currentBackgroundColor)
    }
}
