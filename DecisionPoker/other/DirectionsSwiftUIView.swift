//
//  DirectionsSwiftUIView.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 29.06.20.
//  Copyright © 2020 Jodi Szarko. All rights reserved.
//

import SwiftUI

struct DirectionsSwiftUIView: View {
    
    let directions: LocalizedStringKey = "directions view text"
    
    var body: some View {
        ZStack {
            theme.currentBackgroundColor
            VStack {
                Text(directions)
                    .font(Font.custom(theme.currentFont, size: 16.0, relativeTo: .title))
                    // .scaledFont(name: theme.currentFont, size: 18)
                    .foregroundColor(theme.currentTextColor)
                    .lineSpacing(5.0)
                    .padding(40)
                Spacer()
            }
        } .navigationTitle("Directions")
    }
}
