//
//  SavedDeck+CoreDataProperties.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 08.07.19.
//  Copyright © 2019 Jodi Szarko. All rights reserved.
//
//

import Foundation
import CoreData


extension SavedDeck {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<SavedDeck> {
        return NSFetchRequest<SavedDeck>(entityName: "SavedDeck")
    }

    @NSManaged public var deckName: String?
    @NSManaged public var dateSaved: NSDate?
    @NSManaged public var deckComment: String?
    @NSManaged public var savedChildCards: NSSet?

}

// MARK: Generated accessors for savedChildCards
extension SavedDeck {

    @objc(addSavedChildCardsObject:)
    @NSManaged public func addToSavedChildCards(_ value: SavedCard)

    @objc(removeSavedChildCardsObject:)
    @NSManaged public func removeFromSavedChildCards(_ value: SavedCard)

    @objc(addSavedChildCards:)
    @NSManaged public func addToSavedChildCards(_ values: NSSet)

    @objc(removeSavedChildCards:)
    @NSManaged public func removeFromSavedChildCards(_ values: NSSet)

}
