//
//  ButtonStyle.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 13.07.20.
//  Copyright © 2020 Jodi Szarko. All rights reserved.
//

import Foundation
import SwiftUI




struct StartViewButtonStyle: ButtonStyle {
    var color: Color = .green
    
    public func makeBody(configuration: StartViewButtonStyle.Configuration) -> some View {
        
        configuration.label
            .foregroundColor(.white)
            .padding(15)
            .background(RoundedRectangle(cornerRadius: 10).fill(color))
            .compositingGroup()
            .shadow(color: .black, radius: 3)
            //.opacity(configuration.isPressed ? 0.5 : 1.0)
            //.scaleEffect(configuration.isPressed ? 0.5 : 1.0)
    }
}
