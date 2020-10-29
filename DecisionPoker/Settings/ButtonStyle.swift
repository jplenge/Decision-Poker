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
    var backcolor: Color = .green
    var forecolor: Color = .white
    
    public func makeBody(configuration: StartViewButtonStyle.Configuration) -> some View {
        
        configuration.label
            .foregroundColor(forecolor)
            .padding(10)
            .background(backcolor)
            .compositingGroup()
            .clipShape(Capsule())
            //.background(RoundedRectangle(cornerRadius: 10).fill(backcolor))
            //.shadow(color: .black, radius: 3)
            //.opacity(configuration.isPressed ? 0.5 : 1.0)
            //.scaleEffect(configuration.isPressed ? 0.8 : 1.0)
    }
}


struct StartViewButtonStyleCircle: ButtonStyle {
    var backcolor: Color = .green
    var forecolor: Color = .white
    
    public func makeBody(configuration: StartViewButtonStyle.Configuration) -> some View {
        
        configuration.label
            .foregroundColor(forecolor)
            .padding(10)
            .background(backcolor)
            .compositingGroup()
            .clipShape(Circle())
            //.background(RoundedRectangle(cornerRadius: 10).fill(backcolor))
            //.shadow(color: .black, radius: 3)
            //.opacity(configuration.isPressed ? 0.5 : 1.0)
            //.scaleEffect(configuration.isPressed ? 0.8 : 1.0)
    }
}
