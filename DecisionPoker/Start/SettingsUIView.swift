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
            UINavigationBar.appearance().barTintColor = Theme.currentBackgroundColorUI
            UINavigationBar.appearance().tintColor = Theme.currentTextColorUI
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : Theme.currentTextColorUI, .font : UIFont(name: Theme.currentFont, size: 20) as Any]
        }
    
    var body: some View {
        
        VStack(alignment: .center) {
            List {
                Section(header:  HStack {
                    Text("Appearance")
                        .scaledFont(name: Theme.currentFont, size: 16)
                        .foregroundColor(Theme.sectionHeaderColor)
                        .padding()
                    
                    Spacer()
                }
                .background(Color.white)
                .listRowInsets(EdgeInsets(
                                top: 0,
                                leading: 0,
                                bottom: 0,
                                trailing: 0))
                ){
                    ForEach(Theme.themes.indices, id: \.self) { index in
                        HStack {
                            Text(Theme.themes[index])
                                .scaledFont(name: Theme.currentFont, size: 18)
                                .foregroundColor(Theme.currentTextColor)
                            
                            Spacer()
                            
                            Button(action: {
                                selectedTheme = index
                                Theme.currentBackgroundColor = Theme.colorChoices[index]
                                Theme.currentBackgroundColorUI = Theme.colorChoicesUI[index]
                                Theme.currentFont = Theme.fontChoices[index]
                                Theme.unselectedRadioButtonBackgroundColor = Theme.radioButtonBackgroundColorChoices[index]
                                Theme.sectionHeaderColor = Theme.sectionHeaderColorChoices[index]
                                Theme.startImage = Theme.startImageChoices[index]
                                UserDefaults.standard.set(index, forKey: "SelectedTheme")
                                self.appState.moveToRoot = true
                            }){
                                
                                ZStack {
                                    Circle().fill(index == selectedTheme ? Theme.currentButtonBackgroundColor : Theme.unselectedRadioButtonBackgroundColor).frame(width: 18, height: 18)
                                        .padding()
                                    
                                    if self.selectedTheme == index{
                                        Circle().stroke(Theme.currentButtonBackgroundColor, lineWidth: 4).frame(width: 25, height: 25)
                                    }
                                }
                            }
                        }
                    }
                    .listRowBackground(Theme.currentBackgroundColor)
                }
            }
            .onAppear(){
                UITableView.appearance().backgroundColor = .clear
                UITableViewCell.appearance().backgroundColor = .clear
            }
            .navigationBarTitle("Settings", displayMode: .inline)
            .listStyle(GroupedListStyle())
            Spacer()
            
        }
        .background(Theme.currentBackgroundColor)
    }
}


struct SettingsUIView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsUIView()
    }
}
