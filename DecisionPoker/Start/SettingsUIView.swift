//
//  SettingsUIView.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 29.10.20.
//  Copyright © 2020 Jodi Szarko. All rights reserved.
//

import SwiftUI

struct SettingsUIView: View {
    
    @State var showingAlert: Bool = false
    @State private var selectedTheme : Int = UserDefaults.standard.integer(forKey: "SelectedTheme")
    @AppStorage("SelectedColor") private var selectedColor: Int = 0
    
    var body: some View {
        VStack(alignment: .center) {
            
            VStack(alignment: .leading) {
                Text("Theme Color")
                    .fontWeight(.bold)
                    .fontDesign(.rounded)
                    .font(.subheadline)
                    .foregroundColor(Color("AccentColor"))
                    .padding(.leading)
                    .padding(.top)
                
                CustomColorPicker(selectedColor: $selectedColor)
                    .frame(height: 50)
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: 10
                        )
                    )
            }
            .background(theme.colors[selectedColor])
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 10
                )
            )
            .padding()
            .toolbarBackground(.visible, for: .tabBar, .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Settings")
                            .fontWeight(.bold)
                            .fontDesign(.rounded)
                            .foregroundColor(theme.colors[selectedColor])
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .listStyle(GroupedListStyle())
            
            Spacer()
            
            VStack {
                Button(action: {
                    showingAlert = true
                }, label: {
                    Text("Reset database")
                        .font(.footnote)
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                        .padding(.horizontal)
                })
                .buttonStyle(StartViewButtonStyle(backcolor: Color("AccentColor"), forecolor: theme.colors[selectedColor]))
                .alert("Delete-Database-Alert", isPresented: $showingAlert, actions: {
                    Button("Yes, continue", role: .cancel) { resetDatabase() }
                    Button("Cancel", role: .destructive) {}
                })
                .padding()
            }
        }
        .background(BackgroundCardView().scaledToFit())
    }
}

struct SettingsUIViewPreview: PreviewProvider {
    static var previews: some View {
        SettingsUIView()
    }
}

struct CustomColorPicker: View {
    @Binding var selectedColor: Int
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(theme.colors.indices, id: \.self) { index in
                    Button(action: {
                        self.selectedColor = index
                    }) {
                        Circle()
                            .fill(theme.colors[index])
                            .frame(width: 30, height: 30)
                            .overlay(
                                Circle()
                                    .stroke(Color("AccentColor"), lineWidth: self.selectedColor == index ? 3 : 0)
                            )
                    }
                }
            }
            .padding()
        }
    }
}
