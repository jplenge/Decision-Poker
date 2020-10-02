//
//  StartSwiftUIView.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 24.06.20.
//  Copyright © 2020 Jodi Szarko. All rights reserved.
//

import SwiftUI

struct StartSwiftUIView: View {
    
    @EnvironmentObject var appState: AppState
    
    @State private var navBarHidden = false
    
    @State var isShowingDirectionsView: Bool = false
    @State var isShowingDealingView: Bool = false
    @State var isShowingSavedResultsView: Bool = false
    
    
    var body: some View {
        
        NavigationView {
            VStack   {
                                
                Text("Decision Poker")
                    .fontWeight(.bold)
                    .scaledFont(name: currentFont, size: 48)
                    .foregroundColor(textColor)
                    .padding(.top)
                
                Image("decisionPokerStartImage3")
                    .resizable()
                    .scaledToFit()
                    .padding()
                
                
                
                VStack {
                    NavigationLink(destination: DirectionsSwiftUIView(), isActive: $isShowingDirectionsView) { EmptyView() }
                    
                    Button(action: {
                        self.isShowingDirectionsView = true
                    }){
                        Text("Directions")
                            .scaledFont(name: currentFont, size: 18)
                    }.buttonStyle(StartViewButtonStyle(backcolor: .white, forecolor: backgroundcolorGreen))
                }
                
                
                Spacer()
                
                
                VStack {
                    NavigationLink(destination: DecksSwiftUIView(), isActive: $isShowingDealingView) { EmptyView() }
                    
                    Button(action: {
                        self.isShowingDealingView = true
                    }){
                        Text("Start Dealing Decisions!")
                             .scaledFont(name: currentFont, size: 18)
                             .font(.headline)
                    }.buttonStyle(StartViewButtonStyle(backcolor: .white, forecolor: backgroundcolorGreen))
                }
                
                
                
                Spacer()
                
                
                
                VStack {
                    NavigationLink(destination: SavedResultsSwiftUIView(showBackButton: .constant(false)) , isActive: $isShowingSavedResultsView) { EmptyView() }
                    
                    Button(action: {
                        self.isShowingSavedResultsView = true
                    }){
                        Text("Saved Decisions")
                             .scaledFont(name: currentFont, size: 18)
                    }.buttonStyle(StartViewButtonStyle(backcolor: .white, forecolor: backgroundcolorGreen))
                }
                
                
                Spacer()
                
                
                VStack {
                    
                    Button(action: {
                    }){
                        Text("Contact Us")
                             .scaledFont(name: currentFont, size: 18)
                    }.buttonStyle(StartViewButtonStyle(backcolor: .white, forecolor: backgroundcolorGreen))
                }
                
                Spacer()
               
                
            }.navigationBarTitle("")
                .navigationBarHidden(self.navBarHidden)
                .onAppear(perform: {
                    self.navBarHidden = true
                })
                .onDisappear(perform: {
                    self.navBarHidden = false
                })
            .onReceive(self.appState.$moveToRoot, perform: {moveToRoot in
                if moveToRoot {
                    self.isShowingDealingView = false
                    self.appState.moveToRoot = false
                }
            })
            .background(backgroundcolorGreen)
        }
    }
}


struct StartSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        StartSwiftUIView()
    }
}
