//
//  SavedDeck+CoreDataProperties.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 24.06.20.
//  Copyright © 2020 Jodi Szarko. All rights reserved.
//
//

import Foundation
import CoreData


extension SavedDeck {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedDeck> {
        return NSFetchRequest<SavedDeck>(entityName: "SavedDeck")
    }

    @NSManaged public var dateSaved: Date?
    @NSManaged public var deckComment: String?
    @NSManaged public var deckName: String?
    @NSManaged public var id: UUID?
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
