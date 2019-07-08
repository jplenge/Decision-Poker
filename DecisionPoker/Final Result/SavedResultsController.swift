//
//  SavedResultsController.swift
//  DecisionPoker
//
//  Created by Jodi Szarko on 7/8/19.
//  Copyright © 2019 Jodi Szarko. All rights reserved.
//

import UIKit
import CoreData

class SavedResultsController: FetchedResultsTableViewController {
    
    var container: NSPersistentContainer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedResultsCellIdentifier") as! SavedResultsCell
        
        
        if let deck = fetchedResultsController?.object(at: indexPath as IndexPath) as? SavedDeck {
            deck.managedObjectContext?.performAndWait {
                _ = deck.deckName
            }
            
            cell.deckName.text = deck.deckName
            cell.dateCreated.text = date2String(date: deck.dateSaved!)
            
            var cardString = ""
            for item in deck.savedChildCards?.allObjects as! [SavedCard] {
                cardString = cardString + item.cardName! + "\r"
            }
            cell.cards.text = cardString
            print(cardString)
        }
        return cell
    }
    
    
    
    func date2String(date: NSDate) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return formatter.string(from: date as Date)
    }
    
    private func updateUI() {
        
        let context = container.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedDeck")
        
        request.sortDescriptors = [NSSortDescriptor(
            key: "deckName",
            ascending: true,
            //selector: #selector(NSNumber.compare(_:))
            selector: #selector(NSString.localizedCaseInsensitiveCompare(_:))
            )]
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
    }
    
    
}
