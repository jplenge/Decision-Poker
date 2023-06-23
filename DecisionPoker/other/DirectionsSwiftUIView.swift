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
            VStack {
                Text(directions)
                    .font(Font.custom(theme.currentFont, size: 18.0, relativeTo: .title))
                    .foregroundColor(theme.currentTextColor)
                    .lineSpacing(5.0)
                    .padding(20)
                    .background( theme.currentBackgroundColor)
                    .cornerRadius(8)
                Spacer()
            }
            .padding(
                EdgeInsets(
                    top: 20,
                    leading: 10,
                    bottom: 10,
                    trailing: 20
                )
            )
        }
        .background(BackgroundCardView().scaledToFit())
        .toolbarBackground(
            theme.currentBackgroundColor,
            for: .tabBar, .navigationBar)
        .toolbarBackground(.visible, for: .tabBar, .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
        .scrollContentBackground(.hidden)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("About Decision Poker")
                        .font(Font(UIFont(name: theme.currentFont, size: 24)!))
                        .foregroundColor(Color.white)
                }
            }
        }
    }
}
