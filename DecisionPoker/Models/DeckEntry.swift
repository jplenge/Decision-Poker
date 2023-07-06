//
//  Deck Struct.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 01.07.23.
//  Copyright © 2023 Jodi Szarko. All rights reserved.
//

import Foundation

struct CardEntry: Codable {
    let cardname: String
    let cardcomment: String
}

struct DeckEntry: Codable {
    let deckname: String
    let deckcomment: String
    let cards: [CardEntry]
    
    
  
}
