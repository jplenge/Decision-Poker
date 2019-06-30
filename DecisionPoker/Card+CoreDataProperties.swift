//
//  Card+CoreDataProperties.swift
//  DecisionPoker
//
//  Created by Jodi Szarko on 6/29/19.
//  Copyright © 2019 Jodi Szarko. All rights reserved.
//
//

import Foundation
import CoreData


extension Card {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }

    @NSManaged public var cardName: String?
    @NSManaged public var cardIncluded: Bool
    @NSManaged public var cardComment: String?
    @NSManaged public var cardInformation: Bool
    @NSManaged public var cardsTablePosition: Int16
    @NSManaged public var parentDeck: Deck?

}
