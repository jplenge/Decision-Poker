//
//  AppState.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 25.09.20.
//  Copyright © 2020 Jodi Szarko. All rights reserved.
//

import SwiftUI
import Combine

class AppState: ObservableObject {
    @Published var moveToRoot: Bool = false
}


// Solution from: https://thinkdiff.net/ios/swiftui-how-to-pop-to-root-view/
