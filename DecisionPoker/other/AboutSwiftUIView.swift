//
//  DirectionsSwiftUIView.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 29.06.20.
//  Copyright © 2020 Jodi Szarko. All rights reserved.
//

import SwiftUI

struct AboutSwiftUIView: View {
    @AppStorage("SelectedColor") private var selectedColor: Int = 0
    
    let directions: LocalizedStringKey = "directions view text"
    
    var body: some View {
        ZStack {
                VStack {
                    ScrollView(.vertical, showsIndicators: true) {
                    Text(directions)
                        .foregroundColor(Color("AccentColor"))
                        .font(.body)
                        .padding(20)
                        .background(theme.colors[selectedColor])
                        .cornerRadius(20)
                       
                    Spacer()
                }
                    
                .padding(
                    EdgeInsets(
                        top: 10,
                        leading: 10,
                        bottom: 10,
                        trailing: 10
                    )
                )
            }
        }
        .background(BackgroundCardView().scaledToFit())
        .toolbarBackground(.visible, for: .tabBar, .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
        .scrollContentBackground(.hidden)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("About Decision Poker")
                        .foregroundColor(theme.colors[selectedColor])
                        .fontDesign(.rounded)
                        .fontWeight(.bold)
                }
            }
        }
    }
}
