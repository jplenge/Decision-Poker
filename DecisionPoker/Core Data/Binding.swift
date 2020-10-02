//
//  Binding.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 27.06.20.
//  Copyright © 2020 Jodi Szarko. All rights reserved.
//

import Foundation
import SwiftUI


extension Binding {
    init(_ source: Binding<Value?>, _ defaultValue: Value) {
        // Ensure a non-nil value in `source`.
        if source.wrappedValue == nil {
            source.wrappedValue = defaultValue
        }
        // Unsafe unwrap because *we* know it's non-nil now.
        self.init(source)!
    }
}
