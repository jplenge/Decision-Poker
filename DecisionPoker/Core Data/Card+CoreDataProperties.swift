//
//  Card+CoreDataProperties.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 24.06.20.
//  Copyright © 2020 Jodi Szarko. All rights reserved.
//
//

import Foundation
import CoreData

extension Card {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }
    
    @NSManaged public var cardComment: String?
    @NSManaged public var cardIncluded: Bool
    @NSManaged public var cardInformation: Bool
    @NSManaged public var cardName: String?
    @NSManaged public var cardsTablePosition: Int16
    @NSManaged public var id: UUID?
    @NSManaged public var parentDeck: Deck?
    
}

extension Card: Identifiable { }
