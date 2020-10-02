//
//  Card+CoreDataClass.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 08.07.19.
//  Copyright © 2019 Jodi Szarko. All rights reserved.
//
//

import Foundation
import CoreData


public class Card: NSManagedObject {
    
    public var wrappedCardName: String {
            cardName ?? "Unknown Deck"
        }
    
    public var wrappedCardcomment: String {
        cardComment ?? ""
    }

}
