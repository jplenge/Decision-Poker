//
//  CardsViewController.swift
//  DecisionPoker
//
//  Created by Jodi Szarko on 6/27/19.
//  Copyright © 2019 Jodi Szarko. All rights reserved.
//

import UIKit
import CoreData

var addCardButtonTappedCounter: Int16 = 0

class CardsViewController: FetchedResultsTableViewController, CardsCellDelegate {

    func CardIncluded(sender: CardsCell) {
        if let indexPath  = tableView.indexPath(for: sender) {
            let commit = fetchedResultsController?.object(at: indexPath) as! Card
            commit.cardIncluded = !commit.cardIncluded
        }
    }
    
    func CardNameUpdate(sender: CardsCell, comment: String) {
        if let indexPath  = tableView.indexPath(for: sender) {
            print(comment)
            let commit = fetchedResultsController?.object(at: indexPath) as! Card
            commit.cardName = comment
        }
    }
    
    func CardInfoTapped(sender: CardsCell) {
        if let indexPath  = tableView.indexPath(for: sender) {
            rowTouched = indexPath.row
            let row = tableView.dequeueReusableCell(withIdentifier: "CardsCellIndentifier", for: indexPath) as! CardsCell
            if row.bounds.height == normalCellHeight {
                rowHeight = largeCellHeight
            } else {
                rowHeight = normalCellHeight
            }
        }
        tableView.reloadData()
    }
    
  /*  func SetHeightCardTable(sender: CardsCell) {
        
    }*/
    
    
    func CardCommentUpdate(sender: CardsCell, comment: String) {
        if let indexPath  = tableView.indexPath(for: sender) {
            //print(comment)
            let commit = fetchedResultsController?.object(at: indexPath) as! Card
            commit.cardComment = comment
        }
    }
    
    
    @IBOutlet weak var addCardButton: UIBarButtonItem!
    @IBAction func addCardButtonTapped(_ sender: UIBarButtonItem) {
        
        addCardButtonTappedCounter += 1
        
        //var cardsTotalData: [NSManagedObject] = []
        let managedContext = container.viewContext
        let newCard = Card(context: managedContext)
        newCard.cardName = "New Card \(addCardButtonTappedCounter)"
        newCard.cardComment = "Add comments here"
        newCard.cardsTablePosition = Int16(commitDeckSelected.childCards!.count) + addCardButtonTappedCounter
        newCard.cardIncluded = true
       // print (newCard.cardsTablePosition)
        //let commit = fetchedResultsController?.object(at: IndexPath(index: 0)) as! Deck
        commitDeckSelected.addToChildCards(newCard)
        //newCard.parentDeck(commit)
        
        
     //   \(selectedDeck).addToChildCards(newCard)
      //  cardsTotalData.append(newCard)

        //newDeck.deckName = "New Deck"
        //addDeckButtonTappedCounter += 1
        //print (addDeckButtonTappedCounter)
        /* if addDeckButtonTappedCounter == 1{
         let newCard = Card(context: managedContext)
         newCard.cardName = "New Card"
         newCard.cardComment = "Add comments here"
         
         }
         */
        
        //cardsTotalData.append(newCard)
        try! managedContext.save()
        //  newCard =
        //print(decksTotalData)
    }
    
    var container: NSPersistentContainer!
    var rowTouched: Int = 0
    var expanded: Bool = false
    
    var selectedDeck: String  = ""
    
    var rowHeight: CGFloat = 60
    let normalCellHeight: CGFloat = 60
    let largeCellHeight: CGFloat = 200

    
    var cards: [Card] = []


    
    private func updateUI() {
        print(container)
        let context = container.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Card")
        
        request.predicate = NSPredicate(format: "parentDeck.deckName == '\(selectedDeck)'")

        request.sortDescriptors = [NSSortDescriptor(
            key: "cardsTablePosition",
            ascending: true,
            //selector: #selector(NSString.localizedCaseInsensitiveCompare(_:))
            selector: #selector(NSNumber.compare(_:))
            )]
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
    }

            
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.rightBarButtonItem = self.editButtonItem
        updateUI()
    }
 
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        //let cellHeight = tableView.dequeueReusableCell(withIdentifier: "CardsCellIndentifier") as? CardsCell
        if indexPath.row == rowTouched {
            return rowHeight
        } else {
            return normalCellHeight
        }
        
        
        
        /*
       print("Adjusting height")
        switch cellHeight?.cardInfo.isTouchInside {
        case true:
            print("large")
            return largeCellHeight
        default:
            print("small")
            return normalCellHeight
        }
        tableView.beginUpdates()
        tableView.endUpdates()
        */
 }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
      //  if indexPath == dateLabelIndexPath {
           // isPickerHidden = !isPickerHidden
          //  dueDateLabel.textColor = isPickerHidden ? .black : tableView.tintColor
        //tableView.beginUpdates()
        //tableView.endUpdates()
        
      //  }
    }
    
        
        //return largeCellHeight
        
    


    // MARK: - Table view data source
/*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
*/
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardsCellIndentifier") as? CardsCell
        
        
        if let card = fetchedResultsController?.object(at: indexPath as IndexPath) as? Card {
            card.managedObjectContext?.performAndWait {
                _ = card.cardName
            }
            
            
            cell?.nameOfCard.text = card.cardName
            cell?.cardIsIncluded.isOn = card.cardIncluded
            cell?.cardCommentText.text = card.cardComment
            //cell?.cardInfo = card.cardInformation
            cell?.delegate = self
        }
        return (cell ?? nil)!
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let commit = fetchedResultsController?.object(at: indexPath) as! Card
            container.viewContext.delete(commit as NSManagedObject)
            try! container.viewContext.save()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

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
        if segue.identifier == "DecksReturnSegue" {
            //CardCommentUpdate(sender: )
            let navigationContoller = segue.destination as! UINavigationController
            let controller = navigationContoller.viewControllers.first as! DecksViewController
            controller.container = container
        }
    }
    
    @IBOutlet weak var cardListUpdate: UIBarButtonItem!
    
    @IBAction func cardListUpdateTapped(_ sender: UIBarButtonItem) {
        print(container)
    }
    
        

    
}
