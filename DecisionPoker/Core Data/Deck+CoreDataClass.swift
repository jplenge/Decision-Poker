//
//  Deck+CoreDataClass.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 08.07.19.
//  Copyright © 2019 Jodi Szarko. All rights reserved.
//
//

import Foundation
import CoreData


public class Deck: NSManagedObject {
    
    public var wrappedDeckName: String {
        deckName ?? "Unnamed Deck"
    }
    
    public var wrappedDeckComment: String {
        deckComment ?? ""
    }
    
    
    public var childCardsArray: [Card] {
        let set = childCards as? Set<Card> ?? []
        return set.sorted {
            $0.wrappedCardName < $1.wrappedCardName
        }
    }
    
    public var childCardsActiveArray: [Card] {
        let set = childCards?.filtered(using: NSPredicate(format: "cardIncluded == true")) as? Set<Card> ?? []
        return set.sorted {
            $0.wrappedCardName < $1.wrappedCardName
        }
    }
    
    public var childCardsCount: Int {
        let set = childCards as? Set<Card> ?? []
        
        return set.count
    }
    
    public var activeCards: Int {
        let filtered = childCards?.filtered(using: NSPredicate(format: "cardIncluded == true"))
        return filtered?.count ?? 0
    }
    
    
    public func playGame() -> [Card] {
        var selected: [Card] = []
        
        let possibleCards =  childCards?.filtered(using: NSPredicate(format: "cardIncluded == true"))
        
        // TODO: remove optionals
        while selected.count < numberOfCardsToPick {
            let pick = possibleCards?.randomElement() as! Card
            if !selected.contains(pick) {
                selected.append(pick)
            }
            
        }
        
        return selected
        
    }
    
    public func repickCard(selectedCards: [Card], current: Card) -> Card {
        let possibleCards =  childCards?.filtered(using: NSPredicate(format: "cardIncluded == true"))
        
        var repick: Card
        
        repick = possibleCards?.randomElement() as! Card
    
        // pick new card or if number active cards = number of cards to select then return current card
        if self.activeCards > self.numberOfCardsToPick {
            while selectedCards.contains(repick) {
                repick = possibleCards?.randomElement() as! Card
            }
        } else {
            repick = current
        }
    
        return repick
    }
    
    
}

extension Deck: Identifiable { }

