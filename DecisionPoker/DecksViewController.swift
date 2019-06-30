//
//  DecksViewController.swift
//  DecisionPoker
//
//  Created by Jodi Szarko on 6/27/19.
//  Copyright © 2019 Jodi Szarko. All rights reserved.
//

import UIKit
import CoreData

var addDeckButtonTappedCounter: Int16 = 0
var commitDeckSelected = Deck()
weak var selectedDeck: Deck?

class DecksViewController: FetchedResultsTableViewController, DecksCellDelegate {
    
    func DeckNameUpdate(sender: DecksCell, comment: String) {
        if let indexPath  = tableView.indexPath(for: sender) {
            print(comment)
            let commit = fetchedResultsController?.object(at: indexPath) as! Deck
            commit.deckName = comment
        }
    }
   
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
    func DeckInfoTapped(sender: DecksCell) {
        if let indexPath  = tableView.indexPath(for: sender) {
            rowTouched = indexPath.row
            let row = tableView.dequeueReusableCell(withIdentifier: "DecksCellIdentifier", for: indexPath) as! DecksCell
            if row.bounds.height == normalCellHeight {
                rowHeight = largeCellHeight
                print("no button tapped")
            } else {
                rowHeight = normalCellHeight
                print("button was tapped")
            }
        }
        tableView.reloadData()
    }
    
    func SetHeightDeckTable(sender: DecksCell) {
        
    }
    
    func DealButtonTapped(sender: DecksCell) {
        
        extractedListFromDeckString = ""
        extractedListFromDeckStructure = [Card]()
        extractedListFromDeckStringArray = []
       // extractedListFromDeckSelectedArray = []
        
        fixedItemInListCounter = 0
        
        extractedListLocalString = ""
        extractedListLocalStringArray = []
        extractedListLocalStructure = [[Card] ()]
        
        if let indexPath  = tableView.indexPath(for: sender) {
            rowTouched = indexPath.row
            let row = tableView.dequeueReusableCell(withIdentifier: "DecksCellIdentifier", for: indexPath) as! DecksCell
        //    _ = OutputAndRandomizedArrayWithoutFixedWithSelected(list: "String", number: Int(numberOfCardsToPick))
            
            selectedDeck = fetchedResultsController?.object(at: indexPath) as? Deck

        
        }

        
   
        print("deal is made")
        
        performSegue(withIdentifier: "InitialResultsSegue", sender: nil)
        
    }
    var cardlistButtonIndexPath: IndexPath = []
    
    func CardlistButtonTapped(sender: DecksCell) {
        print("cards pressed")
        
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

    @IBOutlet weak var addDeckButton: UIBarButtonItem!
    
    @IBAction func addDeckButtonTapped(_ sender: UIBarButtonItem) {
        
        addDeckButtonTappedCounter += 1
       
        var decksTotalData: [NSManagedObject] = []
        let managedContext = container.viewContext
        let newDeck = Deck(context: managedContext)
        newDeck.deckName = "New Deck \(addDeckButtonTappedCounter)"
        newDeck.decksTablePosition = addDeckButtonTappedCounter + 2
        newDeck.deckComment = "Add comments here."
        print (newDeck.decksTablePosition)
      //  print (addDeckButtonTappedCounter)
       /* if addDeckButtonTappedCounter == 1{
        let newCard = Card(context: managedContext)
        newCard.cardName = "New Card"
            newCard.cardComment = "Add comments here"
            newDeck.addToChildCards(newCard)
            
        }
 */

        decksTotalData.append(newDeck)
        try! managedContext.save()
        //  newCard =
     //   print(decksTotalData.count)
    }
    var container: NSPersistentContainer!
    
    var rowTouched: Int = 0
    
    
    var rowHeight: CGFloat = 90
    let normalCellHeight: CGFloat = 80
    let largeCellHeight: CGFloat = 200
    
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
    
    var decks: [Deck] = []
    
   // let normalCellHeight: CGFloat = 100

    

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

   // var testName = "deal2!"
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //  if indexPath == dateLabelIndexPath {
        // isPickerHidden = !isPickerHidden
        //  dueDateLabel.textColor = isPickerHidden ? .black : tableView.tintColor
        //tableView.beginUpdates()
        //tableView.endUpdates()
        
        //  }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DecksCellIdentifier") as? DecksCell

        
        if let deck = fetchedResultsController?.object(at: indexPath as IndexPath) as? Deck {
            deck.managedObjectContext?.performAndWait {
                _ = deck.deckName
            }
          //  print (deck)
           
          //  cell?.nameOfDeck.setTitle(deck.deckName, for: .normal) // (deck.deckName, for: UIButton) //= deck.deckName
            cell?.nameOfDeck.text = deck.deckName
            cell?.numberOfResults.text = String(deck.numberOfCardsToPick)
            cell?.resultsNumberChanged.value = Double(deck.numberOfCardsToPick)
            cell?.resultsNumberChanged.maximumValue = Double(deck.childCards!.count)
            cell?.useableCardsInDeck.text = String(deck.childCards!.count)
            cell?.deckCommentText.text = deck.deckComment
            //cell?.dealButton.isEnabled = deck.dealButtonSelector
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
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CardListSegue" {
            let destinationNavigationController = segue.destination as! UINavigationController
            let cardsviewcontroller = destinationNavigationController.viewControllers.first as! CardsViewController
           // let indexPath = tableView.indexPathForSelectedRow!
            commitDeckSelected = fetchedResultsController?.object(at: cardlistButtonIndexPath) as! Deck
            // print("testing")
            //    let selectedCards = commit.childCards
            cardsviewcontroller.selectedDeck = commitDeckSelected.deckName!
            cardsviewcontroller.container = container
            //  print(cardsviewcontroller)
        }
        
        if segue.identifier == "InitialResultsSegue" {
            let destinationController = segue.destination as! ResultsViewController
            destinationController.container = container
            destinationController.selectedDeck = selectedDeck
        }
        
        
    }
    
    /*
    let navigationContoller = segue.destination as! UINavigationController
    let controller = navigationContoller.viewControllers.first as! DecksViewController
    controller.container = container
 */
    
    
    

 

}
