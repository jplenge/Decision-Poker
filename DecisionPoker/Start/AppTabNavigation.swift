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
                        Image(systemName: "list.bullet")
                    }.accessibility(label: menuText)
                }
                .tag(Tab.decks)
            
            DirectionsSwiftUIView()
                .tabItem {
                    let menuText = Text("Directions", comment: "Directions menu tab title")
                    Label {
                        menuText
                    } icon: {
                        Image(systemName: "list.bullet")
                    }.accessibility(label: menuText)
                }
                .tag(Tab.directions)
            
            SavedResultsSwiftUIView(showBackButton: .constant(false), path: $path)
                .tabItem {
                    let menuText = Text("History", comment: "Saved decisions menu tab title")
                    Label {
                        menuText
                    } icon: {
                        Image(systemName: "list.bullet")
                    }
                }
            
            SettingsUIView()
                .tabItem {
                    let menuText = Text("Settings", comment: "Settings menu tab title")
                    Label {
                        menuText
                    } icon: {
                        Image(systemName: "list.bullet")
                    }.accessibility(label: menuText)
                }
        }
        .tint(theme.currentTextColor)
    }
}
