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
    
    @IBOutlet var backButton: UIBarButtonItem!
    
    var backButtonText = "Start Over"
    
    var container: NSPersistentContainer!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        updateUI()
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
        
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        
        backButton.title = backButtonText
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedResultsCellIdentifier") as! SavedResultsCell
        
        
        if let deck = fetchedResultsController?.object(at: indexPath as IndexPath) as? SavedDeck {
            deck.managedObjectContext?.performAndWait {
                _ = deck.deckName
            }
            
            cell.savedREsultDeckname.text = deck.deckName
            cell.savedResultDate.text = date2String(date: deck.dateSaved!)
            
            var cardString = ""
            for item in deck.savedChildCards?.allObjects as! [SavedCard] {
                cardString = cardString + "\u{2022} " + item.cardName! + "\r"
            }
            
            cell.savedResultCards.text = cardString
        }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let commit = fetchedResultsController?.object(at: indexPath) as! SavedDeck
            container.viewContext.delete(commit as NSManagedObject)
            try! container.viewContext.save()
        } else if editingStyle == .insert {
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ReturnToDecksSegue" {
            // let destinationController = segue.destination as! SavedResultsController
            // destinationController.container = container
            
            let navigationContoller = segue.destination as! UINavigationController
            let controller = navigationContoller.viewControllers.first as! StartViewController
            controller.container = container
            //saveFinalDeck()
        }
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
            key: "dateSaved",
            ascending: false
            )]
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
    }
  
}
