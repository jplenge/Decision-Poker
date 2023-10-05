//
//  CustomToggle.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 24.09.20.
//  Copyright © 2020 Jodi Szarko. All rights reserved.
//

import Foundation
import SwiftUI

struct CheckboxToggleStyle: ToggleStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .resizable()
                .frame(width: 20, height: 20)
                .onTapGesture { configuration.isOn.toggle() }
        }
    }
}
