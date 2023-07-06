//
//  AppSidebarNavigation.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 27.05.23.
//  Copyright © 2023 Jodi Szarko. All rights reserved.
//

import SwiftUI
import UIKit

struct AppSidebarNavigation: View {
    
    enum NavigationItem {
        case decks
        case savedDecisions
        case settings
        case about
    }
    
    @State private var selection: NavigationItem? = .decks
    @State private var path = NavigationPath()
    @AppStorage("SelectedColor") private var selectedColor = 0
    
    init() {
           //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]

           //Use this if NavigationBarTitle is with displayMode = .inline
           UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
       }
    
    var body: some View {
        NavigationSplitView(columnVisibility: .constant(.all)) {
                List(selection: $selection) {
                    NavigationLink(value: NavigationItem.decks) {
                        Label("Decks", systemImage: "rectangle.on.rectangle")
                    }
                    
                    NavigationLink(value: NavigationItem.savedDecisions) {
                        Label("Saved Decisions", systemImage: "bookmark.circle.fill")
                    }
                    
                    NavigationLink(value: NavigationItem.settings) {
                        Label("Settings", systemImage: "gearshape")
                    }
                    
                    NavigationLink(value: NavigationItem.about) {
                        Label("About", systemImage: "list.bullet")
                    }
                }
                .navigationTitle(String(localized: "Decision Poker", comment: "/"))
                .background(themeColor.colors[selectedColor])
                .foregroundColor(Color.white)
                .accentColor(themeColor.colors[selectedColor])
                .scrollContentBackground(.hidden)
                //.tint(.blue.opacity(0.5))
        }
    detail: {
        if let selection {
            switch selection {
            case .decks:
                NavigationStack(path: $path) {
                    DecksSwiftUIView(path: $path)
                }
            case .savedDecisions:
                NavigationStack {
                    SavedResultsSwiftUIView(showBackButton: .constant(false), path: $path)
                }
            case .settings:
                SettingsUIView()
            case .about:
                DirectionsSwiftUIView()
            }
            
        } else {
            Text("Select something")
        }
    }
    .navigationSplitViewStyle(.balanced)
    .accentColor(Color.white)
    }
}
