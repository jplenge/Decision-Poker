//
//  SavedDeck+CoreDataClass.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 08.07.19.
//  Copyright © 2019 Jodi Szarko. All rights reserved.
//
//

import Foundation
import CoreData

@objc(SavedDeck)
public class SavedDeck: NSManagedObject {
    
    public var wrappedDeckName: String {
        deckName ?? "Unnamed Deck"
    }
    
    public var wrappedDeckComment: String {
        deckComment ?? ""
    }
    
    
    public var savedCardsArray: [SavedCard] {
        let set = savedChildCards as? Set<SavedCard> ?? []
        return set.sorted {
            $0.wrappedCardName < $1.wrappedCardName
        }
    }
    
    public var creationDateFormatted: String  {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        
        return formatter.string(from: dateSaved ?? Date())
    }
}
