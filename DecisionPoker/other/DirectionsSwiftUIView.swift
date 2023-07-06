//
//  DirectionsSwiftUIView.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 29.06.20.
//  Copyright © 2020 Jodi Szarko. All rights reserved.
//

import SwiftUI

struct DirectionsSwiftUIView: View {
    @AppStorage("SelectedColor") private var selectedColor: Int = 0
    
    let directions: LocalizedStringKey = "directions view text"
    
    var body: some View {
        ZStack {
                VStack {
                    ScrollView(.vertical, showsIndicators: true) {
                    Text(directions)
                        .fontWidth(.condensed)
                        .foregroundColor(Color("AccentColor"))
                        .lineSpacing(5.0)
                        .padding(20)
                        .background(themeColor.colors[selectedColor])
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
        }
        .background(BackgroundCardView().scaledToFit())
        .toolbarBackground(
            themeColor.colors[selectedColor],
            for: .tabBar, .navigationBar)
        .toolbarBackground(.visible, for: .tabBar, .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
        .scrollContentBackground(.hidden)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("About Decision Poker")
                        .foregroundColor(Color("AccentColor"))
                }
            }
        }
    }
}
