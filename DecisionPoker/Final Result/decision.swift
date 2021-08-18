//
//  File.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 04.06.21.
//  Copyright © 2021 Jodi Szarko. All rights reserved.
//

import Foundation

struct Decision: Codable {
    var deckname: String
    var date: Date
    var selectedCards: [String]
}
