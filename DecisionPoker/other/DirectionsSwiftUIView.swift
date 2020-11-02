//
//  DirectionsSwiftUIView.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 29.06.20.
//  Copyright © 2020 Jodi Szarko. All rights reserved.
//

import SwiftUI

struct DirectionsSwiftUIView: View {
    
    // variable to store status of navigation bar
    
    let directions: LocalizedStringKey = "This decision making app enables you to choose one or multiple results from a list of choices. It likens the decision making process to a game of poker. Each topic is entered as a \"deck\", and each choice in a deck is entered as a \"card\". To get started, press the \"Start dealing decisions!\" button in the start screen. The app will display two starter \"decks\", colors and household chores, but you can add and edit your own decks and cards. Some instructions and clarifications are indicated if the \"info\" or \"?\" button in each screen is pressed. Once your selections are optimized, simply hit \"Deal!\" to create your randomized \"hand\" or decision! Once the decision is made, you can fix and redraw any of the choices of your result. If you are happy with the decision the app has made, you can see, send and save your finalized solutions. Sometimes making decisions is stressful. We hope this app makes the process more fun and efficient!"
    
    
    var body: some View {
        Group {
            Text(directions)
                .padding()
                .scaledFont(name: Theme.currentFont, size: 18)
                .foregroundColor(Theme.currentTextColor)
            
            Spacer()
            
        }.navigationBarTitle("Directions", displayMode: .inline)
        .navigationBarHidden(false)
        .background(Theme.currentBackgroundColor)
        
    }
    
}

struct DirectionsSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        DirectionsSwiftUIView()
    }
}
