//
//  JSON Helper Functions .swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 01.07.23.
//  Copyright © 2023 Jodi Szarko. All rights reserved.
//

import Foundation
import CoreData

func readLocalJSONFile(forName name: String) -> Data? {
    do {
        if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
            let fileUrl = URL(fileURLWithPath: filePath)
            let data = try Data(contentsOf: fileUrl)
            return data
        }
    } catch {
        print("error: \(error)")
    }
    return nil
}

func parse(jsonData: Data) -> DeckEntry? {
    do {
        let decodedData = try JSONDecoder().decode(DeckEntry.self, from: jsonData)
        return decodedData
    } catch {
        print("error: \(error)")
    }
    return nil
}

func writeToCoreData(entry: DeckEntry) {
    let persistenceController = PersistenceController.shared
    let context = persistenceController.container.viewContext
    
    let deck = Deck(context: context)
    deck.deckName = entry.deckname
    deck.deckComment = entry.deckcomment
    deck.numberOfCardsToPick = entry.cards.count >= 5 ? 3 : 1
    deck.dealButtonSelector = true
    deck.decksTablePosition = 0
    deck.id = UUID()
    
    for (pos, item) in entry.cards.enumerated() {
        let card = Card(context: context)
        card.cardName = item.cardname
        card.cardComment = item.cardcomment
        card.cardIncluded = true
        card.cardsTablePosition = Int16(pos)
        card.id = UUID()
        card.cardInformation = false
        deck.addToChildCards(card)
    }
    
    do {
        try context.save()
    } catch let error as NSError {
        print("Could not save \(error), \(error.userInfo)")
    }
}

func initializeDatabase(with jsonFile: String) {
    let jsonData = readLocalJSONFile(forName: jsonFile)
    if let data = jsonData {
        if let parsedData = parse(jsonData: data) {
            writeToCoreData(entry: parsedData)
        }
    }
}

func deleteAllData(entity: String) {
    let persistenceController = PersistenceController.shared
    let managedContext = persistenceController.container.viewContext
    
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    fetchRequest.returnsObjectsAsFaults = false
    
    do {
        let results = try managedContext.fetch(fetchRequest)
        for managedObject in results {
            if let managedObjectData:NSManagedObject = managedObject as? NSManagedObject {
                managedContext.delete(managedObjectData)
            }
        }
    } catch let error as NSError {
        print("Delete all data in \(entity) error : \(error) \(error.userInfo)")
    }
}

func resetDatabase() {
    //  UserDefaults.standard.stringArray(forKey: "AppleLanguages")
    if let language = Locale.current.language.languageCode?.identifier {
        if language.contains("de") {
            deleteAllData(entity: "Deck")
            deleteAllData(entity: "Card")
            initializeDatabase(with: "household-chores-de")
            initializeDatabase(with: "colors-de")
            initializeDatabase(with: "books-de")
        } else {
            deleteAllData(entity: "Deck")
            deleteAllData(entity: "Card")
            initializeDatabase(with: "household-chores-en")
            initializeDatabase(with: "colors-en")
            initializeDatabase(with: "books-en")
        }
    }
}
