//
//  dismissKeyboardExtension.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 22.09.20.
//  Copyright © 2020 Jodi Szarko. All rights reserved.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
