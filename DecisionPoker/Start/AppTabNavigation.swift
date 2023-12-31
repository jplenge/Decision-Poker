//
//  AppTabNavigation.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 23.05.23.
//  Copyright © 2023 Jodi Szarko. All rights reserved.
//

import SwiftUI

struct AppTabNavigation: View {
    
    enum Tab {
        case decks
        case history
        case directions
        case settings
    }
    
    @State private var selection: Tab = .decks
    @State private var path = NavigationPath()
    @AppStorage("SelectedColor") private var selectedColor: Int = 0
    
    var body: some View {
        TabView(selection: $selection) {
            
            NavigationStack(path: $path) {
                DecksSwiftUIView(path: $path)
            }
            .tabItem {
                let menuText = Text("Decks", comment: "Decks menu tab title")
                Label {
                    menuText
                } icon: {
                    Image(systemName: "square.stack.3d.up.fill")
                }.accessibility(label: menuText)
            }
            .tag(Tab.decks)
            
            NavigationStack {
                SavedResultsSwiftUIView(showBackButton: .constant(false), path: $path)
            }
            .tabItem {
                let menuText = Text("Saved Decisions", comment: "Saved decisions menu tab title")
                Label {
                    menuText
                } icon: {
                    Image(systemName: "bookmark.circle.fill")
                }.accessibility(label: menuText)
            }
            .tag(Tab.history)
            
            NavigationStack {
                SettingsUIView()
            }
                .tabItem {
                    let menuText = Text("Settings", comment: "Settings menu tab title")
                    Label {
                        menuText
                    } icon: {
                        Image(systemName: "gearshape")
                    }.accessibility(label: menuText)
                        .accessibilityIdentifier("settings.btn")
                }
           
            NavigationStack {
                AboutSwiftUIView()
            }
                .tabItem {
                    let menuText = Text("About", comment: "Directions menu tab title")
                    Label {
                        menuText
                    } icon: {
                        Image(systemName: "list.bullet")
                    }.accessibility(label: menuText)
                        .foregroundColor(.red)
                }
                .tag(Tab.directions)
               
        }
        .tint(theme.colors[selectedColor])
    }
}
