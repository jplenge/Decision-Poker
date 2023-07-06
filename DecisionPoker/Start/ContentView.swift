//
//  ContentView.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 23.05.23.
//  Copyright © 2023 Jodi Szarko. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext

    #if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    #endif
    
    var body: some View {
        #if os(iOS)
        if horizontalSizeClass == .compact {
            AppTabNavigation()
        } else {
             AppSidebarNavigation()
        }
        #else
        AppSidebarNavigation()
        #endif
    }
}
