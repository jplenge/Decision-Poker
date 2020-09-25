//
//  SavedCard+CoreDataProperties.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 24.06.20.
//  Copyright © 2020 Jodi Szarko. All rights reserved.
//
//

import Foundation
import CoreData


extension SavedCard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedCard> {
        return NSFetchRequest<SavedCard>(entityName: "SavedCard")
    }

    @NSManaged public var cardComment: String?
    @NSManaged public var cardName: String?
    @NSManaged public var id: UUID?
    @NSManaged public var savedParentDeck: SavedDeck?

}
