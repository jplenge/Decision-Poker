//
//  DecksViewController.swift
//  DecisionPoker
//
//  Created by Jodi Szarko on 6/27/19.
//  Copyright © 2019 Jodi Szarko. All rights reserved.
//

import UIKit
import CoreData


class DecksViewController: FetchedResultsTableViewController, DecksCellDelegate {
    
    func ChangeCardNumberTapped(sender: DecksCell) {
        if let indexPath  = tableView.indexPath(for: sender) {
            let commit = fetchedResultsController?.object(at: indexPath) as! Deck
            commit.numberOfCardsToPick = Int16(Int(sender.resultsNumberChanged.value))
        }
    }
    
    /*
    
    func DeckButtonTapped(sender: DecksCell) {
        
        if let indexPath  = tableView.indexPath(for: sender) {
            let commit = fetchedResultsController?.object(at: indexPath) as! Deck
         
            /*
            //  performSegue(withIdentifier: "CardListSegue", sender: nil)
            let destinationNavigationController = segue.destination as! UINavigationController
            let cardsviewcontroller = destinationNavigationController.viewControllers.first as! CardsViewController
            //let indexPath = tableView.indexPathForSelectedRow!
            // let commit = fetchedResultsController?.object(at: indexPath) as! Deck
            print("testing")
            //    let selectedCards = commit.childCards
            cardsviewcontroller.selectedDeck = commit.deckName!
            //foodlistviewcontroller.foodlistitems = selectedFoodGroupItems?.allObjects as! [Food_List_Item]
            cardsviewcontroller.container = container
           // performSegue(withIdentifier: "CardListSegue", sender: nil)
 */

        }
    }
 */
    
    func DealButtonTapped(sender: DecksCell) {
        
        if let indexPath  = tableView.indexPath(for: sender) {
            let commit = fetchedResultsController?.object(at: indexPath) as! Deck
            commit.dealButtonSelector = !commit.dealButtonSelector
        }
    }


   var container: NSPersistentContainer!
    
    private func updateUI() {
    
        let context = container.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Deck")
        
        request.sortDescriptors = [NSSortDescriptor(
            key: "deckName",
            ascending: true,
            selector: #selector(NSString.localizedCaseInsensitiveCompare(_:))
            )]
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
    }
    
    var decks: [Deck] = []
    
    let normalCellHeight: CGFloat = 100


    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.

        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        updateUI()
    }

    // MARK: - Table view data source

  /*  override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
 */

    var testName = "deal2!"
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DecksCellIdentifier") as? DecksCell

        
        if let deck = fetchedResultsController?.object(at: indexPath as IndexPath) as? Deck {
            deck.managedObjectContext?.performAndWait {
                _ = deck.deckName
            }
            
           
          //  cell?.nameOfDeck.setTitle(deck.deckName, for: .normal) // (deck.deckName, for: UIButton) //= deck.deckName
            cell?.nameOfDeck.text = deck.deckName
            cell?.numberOfResults.text = String(deck.numberOfCardsToPick)
            cell?.resultsNumberChanged.value = Double(deck.numberOfCardsToPick)
            cell?.resultsNumberChanged.maximumValue = Double(deck.childCards!.count)
            cell?.useableCardsInDeck.text = String(deck.childCards!.count)
            //cell?.dealButton.isEnabled = deck.dealButtonSelector
            cell?.delegate = self
        }
        return (cell ?? nil)!
    }
   
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return normalCellHeight
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

  /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
 */
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CardListSegue" {
            let destinationNavigationController = segue.destination as! UINavigationController
            let cardsviewcontroller = destinationNavigationController.viewControllers.first as! CardsViewController
            let indexPath = tableView.indexPathForSelectedRow!
             let commit = fetchedResultsController?.object(at: indexPath) as! Deck
            print("testing")
            //    let selectedCards = commit.childCards
            cardsviewcontroller.selectedDeck = commit.deckName!
            cardsviewcontroller.container = container
            print(cardsviewcontroller)
        }
    }
 
  
    
    
    

 

}
