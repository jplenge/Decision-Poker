//
//  Deck+CoreDataProperties.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 24.06.20.
//  Copyright © 2020 Jodi Szarko. All rights reserved.
//
//

import Foundation
import CoreData


extension Deck {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Deck> {
        return NSFetchRequest<Deck>(entityName: "Deck")
    }

    @NSManaged public var dealButtonSelector: Bool
    @NSManaged public var deckComment: String?
    @NSManaged public var deckName: String?
    @NSManaged public var decksTablePosition: Int16
    @NSManaged public var numberOfCardsToPick: Int16
    @NSManaged public var id: UUID?
    @NSManaged public var childCards: NSSet?

}

// MARK: Generated accessors for childCards
extension Deck {

    @objc(addChildCardsObject:)
    @NSManaged public func addToChildCards(_ value: Card)

    @objc(removeChildCardsObject:)
    @NSManaged public func removeFromChildCards(_ value: Card)

    @objc(addChildCards:)
    @NSManaged public func addToChildCards(_ values: NSSet)

    @objc(removeChildCards:)
    @NSManaged public func removeFromChildCards(_ values: NSSet)

}
