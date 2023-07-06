//
//  ViewModel.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 26.06.23.
//  Copyright © 2023 Jodi Szarko. All rights reserved.
//

import Foundation

@MainActor class ViewModel: ObservableObject {
    @Published var selectedDeck = Deck()
    @Published var gameResult: [Card] = []
    
    func redrawCard(index: Int) {
        gameResult[index] = selectedDeck.repickCard(selectedCards: gameResult, current: gameResult[index])
    }
}
