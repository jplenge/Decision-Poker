//
//  DecksViewController.swift
//  DecisionPoker
//
//  Created by Jodi Szarko on 6/27/19.
//  Copyright © 2019 Jodi Szarko. All rights reserved.
//
/* Note: This is the Table View Controller that shows the "Decks," or the list of topics to choose decisions from.  The file has the following sections:
 
 1) global variables - defines variables outside the table view class to be used in other classes
 2) protocol functions - defines functions called in the protocol in the cell controller
 3) storyboard objects - defines linked graphics components in the cell
 4) variables- user defined variables and delegates used by the cell or the table view
 5) storyboard actions - defines actions performed by graphics components in the cell if they are not defined in section 2
 6) additional functions - defines functions created by the user but not called in the protocol
 7) table view functions - defines functions automatically defined in a table view class
 8) unused code - area for test code used previously in the file - it can be reused at a leter time if the program requires it.
 
 */

import UIKit
import CoreData

// SECTION 1- GLOBAL VARIABLES//

var addDeckButtonTappedCounter: Int16 = 0
var commitDeckSelected = Deck()
var selectedDeck =  Deck()

// END SECTION 1- GLOBAL VARIABLES//

class DecksViewController: FetchedResultsTableViewController, DecksCellDelegate {
    
    // SECTION 2- PROTOCOL FUNCTIONS//
    
    
    func DeckNameUpdate(sender: DecksCell, comment: String) {
        if let indexPath  = tableView.indexPath(for: sender) {
            let commit = fetchedResultsController?.object(at: indexPath) as! Deck
            commit.deckName = comment
            let context =  container.viewContext
            try! context.save()
        }
    }
    
    func ChangeCardNumberTapped(sender: DecksCell) {
        if let indexPath  = tableView.indexPath(for: sender) {
            let commit = fetchedResultsController?.object(at: indexPath) as! Deck
            commit.numberOfCardsToPick = Int16(Int(sender.resultsNumberChanged.value))
            let context =  container.viewContext
            try! context.save()
        }
    }
    
    func DeckInfoTapped(sender: DecksCell) {
        if let indexPath  = tableView.indexPath(for: sender) {
            rowTouched = indexPath.row
            let row = tableView.dequeueReusableCell(withIdentifier: "DecksCellIdentifier", for: indexPath) as! DecksCell
            if row.bounds.height == normalCellHeight {
                rowHeight = largeCellHeight
            } else {
                rowHeight = normalCellHeight
            }
        }
        tableView.reloadData()
        
    }
    
    func DealButtonTapped(sender: DecksCell) {
         var numberOfSelectableCards = 0
        
        if let indexPath  = tableView.indexPath(for: sender) {
            selectedDeck = (fetchedResultsController?.object(at: indexPath) as? Deck)!
            
           
            for item in selectedDeck.childCards?.allObjects as! [Card] {
                numberOfSelectableCards += Int(truncating: NSNumber(value: item.cardIncluded))
            }
        }
        
        if ((selectedDeck.childCards!.allObjects as! [Card]).filter{$0.cardIncluded == true}).count > 1 {
            
            if selectedDeck.numberOfCardsToPick <= numberOfSelectableCards {
                performSegue(withIdentifier: "InitialResultsSegue", sender: nil)
            } else {
                let alertController = UIAlertController(title: NSLocalizedString("Selection Invalid", comment: ""), message: NSLocalizedString("You need to either a) increase the number of cards in the deck or b) decrease the number of card choices that will be in your hand!", comment: ""), preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) -> Void in })
                
                alertController.addAction(okAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
            
        } else {
            
            let alertController = UIAlertController(title: NSLocalizedString("Selection Invalid", comment: ""), message: NSLocalizedString("You need more than one card to deal!", comment: ""), preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) -> Void in })
            
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    
    func CardlistButtonTapped(sender: DecksCell) {
        guard let indexPath = self.tableView.indexPath(for: sender) else {
            return
        }
        cardlistButtonIndexPath = indexPath
        performSegue(withIdentifier: "CardListSegue", sender: nil)
    }
    
    
    
    func DeckCommentUpdate(sender: DecksCell, comment: String) {
        if let indexPath  = tableView.indexPath(for: sender) {
            print(comment)
            let commit = fetchedResultsController?.object(at: indexPath) as! Deck
            commit.deckComment = comment
        }
    }
    
    // END SECTION 2 - PROTOCOL FUNCTIONS//
    
    // SECTION 3- STORYBOARD OBJECTS//
    
    @IBOutlet weak var addDeckButton: UIBarButtonItem!
    
    // END SECTION 3- STORYBOARD OBJECTS//
    
    // SECTION 4 - VARIABLES//
    
    var container: NSPersistentContainer!
    
    var rowTouched: Int = -1
    var rowHeight: CGFloat = 105
    let normalCellHeight: CGFloat = 105
    let largeCellHeight: CGFloat = 255
    
    var cardlistButtonIndexPath: IndexPath = []
    var decks: [Deck] = []
    
    
    // END SECTION 4 - VARIABLES//
    
    // SECTION 5- STORYBOARD ACTIONS//
    
    @IBAction func addDeckButtonTapped(_ sender: UIBarButtonItem) {
        
        addDeckButtonTappedCounter += 1
        
        var decksTotalData: [NSManagedObject] = []
        let managedContext = container.viewContext
        let newDeck = Deck(context: managedContext)
        newDeck.deckName = "New Deck \(addDeckButtonTappedCounter)"
        newDeck.decksTablePosition = addDeckButtonTappedCounter + 2
        newDeck.deckComment = NSLocalizedString("Add comments here.", comment: "")
        
        
        decksTotalData.append(newDeck)
        try! managedContext.save()
    }
    
    // END SECTION 5- STORYBOARD ACTIONS//
    
    // SECTION 6- ADDITIONAL FUNCTIONS//
    
    private func updateUI() {
        
        let context = container.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Deck")
        
        request.sortDescriptors = [NSSortDescriptor(
            key: "decksTablePosition",
            ascending: true,
            selector: #selector(NSNumber.compare(_:))
            //selector: #selector(NSString.localizedCaseInsensitiveCompare(_:))
            )]
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
    }
    
    @IBOutlet weak var cancelButtonDecks: UIBarButtonItem!
    
    @IBAction func cancelDecksTapped(_ sender: Any) {
        performSegue(withIdentifier: "CancelSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CardListSegue" {
            let destinationNavigationController = segue.destination as! UINavigationController
            let cardsviewcontroller = destinationNavigationController.viewControllers.first as! CardsViewController
            commitDeckSelected = fetchedResultsController?.object(at: cardlistButtonIndexPath) as! Deck
            cardsviewcontroller.selectedDeck = commitDeckSelected.deckName!
            cardsviewcontroller.container = container
        }
        
        if segue.identifier == "InitialResultsSegue" {
            let destinationController = segue.destination as! DealResultsViewController
            destinationController.container = container
            destinationController.selectedDeck = selectedDeck
        }
        
        if segue.identifier == "CancelSegue" {
            let destinationController = segue.destination as! StartNavigationController
            let controller = destinationController.viewControllers.first as! StartViewController
            controller.container = container
        }
    }
    
    // END SECTION 6- ADDITIONAL FUNCTIONS//
    
    
    
    // SECTION 7- TABLE VIEW FUNCTIONS//

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        updateUI()
    }
    
 
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DecksCellIdentifier") as? DecksCell
        
        
        
        if let deck = fetchedResultsController?.object(at: indexPath as IndexPath) as? Deck {
            deck.managedObjectContext?.performAndWait {
                _ = deck.deckName
            }
            
            var totalCardsIncludedMarker: Int = 0
            
            let results2 = deck.childCards?.allObjects as! [Card]
            
            
            for item in results2 {
                totalCardsIncludedMarker += Int(truncating: NSNumber(value: item.cardIncluded))
            }
            
            cell?.nameOfDeck.text = deck.deckName
            cell?.numberOfResults.text = String(deck.numberOfCardsToPick)
            cell?.resultsNumberChanged.value = Double(deck.numberOfCardsToPick)
            cell?.resultsNumberChanged.maximumValue = Double(totalCardsIncludedMarker)
            cell?.useableCardsInDeck.text = String(totalCardsIncludedMarker)
            cell?.deckCommentText.text = deck.deckComment
            cell?.delegate = self
        }
        return (cell ?? nil)!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == rowTouched {
            return rowHeight
        } else {
            return normalCellHeight
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let commit = fetchedResultsController?.object(at: indexPath) as! Deck
            container.viewContext.delete(commit as NSManagedObject)
            try! container.viewContext.save()
        } else if editingStyle == .insert {
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // END SECTION 7- TABLE VIEW FUNCTIONS//
    
    
    
    
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
    /*
     
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     if segue.identifier == "CardListSegue" {
     let destinationNavigationController = segue.destination as! UINavigationController
     let cardsviewcontroller = destinationNavigationController.viewControllers.first as! CardsViewController
     let indexPath = tableView.indexPathForSelectedRow!
     commitDeckSelected = fetchedResultsController?.object(at: indexPath) as! Deck
     // print("testing")
     //    let selectedCards = commit.childCards
     cardsviewcontroller.selectedDeck = commitDeckSelected.deckName!
     cardsviewcontroller.container = container
     //  print(cardsviewcontroller)
     }
     }
     */
    
    
    
    /*
     let navigationContoller = segue.destination as! UINavigationController
     let controller = navigationContoller.viewControllers.first as! DecksViewController
     controller.container = container
     */
    
    
    
    
    
    
}

/*
 
 // SECTION 8- UNUSED CODE//
 
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


/*
 func SetHeightDeckTable(sender: DecksCell) {
 
 }
 
 func DealButtonTapped(sender: DecksCell) {
 /*
 extractedListFromDeckString = ""
 extractedListFromDeckStructure = [Card]()
 extractedListFromDeckStringArray = []
 // extractedListFromDeckSelectedArray = []
 
 fixedItemInListCounter = 0
 
 extractedListLocalString = ""
 extractedListLocalStringArray = []
 extractedListLocalStructure = [[Card] ()]
 */
 if let indexPath  = tableView.indexPath(for: sender) {
 //rowTouched = indexPath.row
 //let row = tableView.dequeueReusableCell(withIdentifier: "DecksCellIdentifier", for: indexPath) as! DecksCell
 selectedDeck = (fetchedResultsController?.object(at: indexPath) as? Deck)!
 
 }
 print("deal is made")
 
 performSegue(withIdentifier: "InitialResultsSegue", sender: nil)
 
 }
 */

// END SECTION 8- UNUSED CODE//
