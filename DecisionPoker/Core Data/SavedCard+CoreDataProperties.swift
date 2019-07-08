//
//  SavedCard+CoreDataProperties.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 08.07.19.
//  Copyright © 2019 Jodi Szarko. All rights reserved.
//
//

import Foundation
import CoreData


extension SavedCard {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<SavedCard> {
        return NSFetchRequest<SavedCard>(entityName: "SavedCard")
    }

    @NSManaged public var cardComment: String?
    @NSManaged public var cardName: String?
    @NSManaged public var savedParentDeck: SavedDeck?

}
