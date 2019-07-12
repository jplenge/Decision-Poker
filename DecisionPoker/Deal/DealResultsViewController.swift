//
//  DealResultsViewController.swift
//  DecisionPoker
//
//  Created by Jodi Szarko on 7/3/19.
//  Copyright © 2019 Jodi Szarko. All rights reserved.
//

import UIKit
import CoreData




class DealResultsViewController: UIViewController, DealResultsTableViewCellDelegate {
    
    
    var selectedCards: [Card] = []
    var container: NSPersistentContainer!
    weak var selectedDeck: Deck?
    
    //var rowTouched: Int = 0
    var rowHeight: CGFloat = 80
    let normalCellHeight: CGFloat = 80
    let largeCellHeight: CGFloat = 220
    
    var finalCardsData: String = ""
    
    
    func PickerItemSelected(sender: DealResultsTableViewCell, item: Int) {
        print("Picker item: \(item)")
        
        if let indexPath  = sender.getIndexPath() {
            
           
            
            if let vc = self.children.first(where: { $0 is DealResultsTableViewController }) as? DealResultsTableViewController {
                
                let possibleItems = (selectedDeck?.childCards?.allObjects as! [Card]).filter {$0.cardIncluded == true}
                
                vc.selectedCards[indexPath.row] = possibleItems[item]
                
                if !selectedCards.contains(possibleItems[item]) {
                    selectedCards[indexPath.row] = possibleItems[item]
                    //selectionSuccess = true
                }
                
                vc.tableView.reloadData()
            }
        }
    } 
    
    
    
    func CheatTapped(sender: DealResultsTableViewCell) {
        
        if let indexPath  = sender.getIndexPath() {
            
            if let vc = self.children.first(where: { $0 is DealResultsTableViewController }) as? DealResultsTableViewController {
                
                vc.rowTouched = indexPath.row
                
                let row =  vc.tableView.dequeueReusableCell(withIdentifier: "DealResultsCell", for: indexPath) as! DealResultsTableViewCell
                
                if row.bounds.height == normalCellHeight {
                    vc.rowHeight = largeCellHeight
                } else {
                    vc.rowHeight = normalCellHeight
                }
                vc.tableView.beginUpdates()
                vc.tableView.endUpdates()
            }
        }
        
    }
    
    /*
     func RedrawTapped(sender: DealResultsTableViewCell) {
     print ("redraw tapped")
     
     
     let indexPath = sender.getIndexPath()
     //print(indexPath)
     
     var selectionSuccess = false
     
     repeat {
     let newSelection = selectedCards[indexPath!.row].parentDeck?.childCards?.allObjects.randomElement() as! Card
     //  print(newSelection.cardName)
     
     if !selectedCards.contains(newSelection) {
     selectedCards[indexPath!.row] = newSelection
     selectionSuccess = true
     }
     } while !selectionSuccess
     
     
     /* if let vc = self.children.first(where: { $0 is DealResultsTableViewController }) as? DealResultsTableViewController {
     vc.selectedCards = self.selectedCards
     vc.tableView.reloadData()
     }
     */
     
     self.tableView.reloadData()
     
     
     }
     */
    
    func RedrawTapped(sender: DealResultsTableViewCell) {
       // print("redraw button pressed")
        
        let indexPath = sender.getIndexPath()
        
        var selectionSuccess = false
        
        repeat {
        let newSelection = ((selectedCards[indexPath!.row].parentDeck?.childCards?.allObjects as! [Card]).filter {$0.cardIncluded == true}).randomElement()
       // print (newSelection)
        
        
            if !selectedCards.contains(newSelection!) {
            selectedCards[indexPath!.row] = newSelection!
                selectionSuccess = true

                
            }
        print(selectedCards[indexPath!.row].cardName!)
            
            if let vc = self.children.first(where: { $0 is DealResultsTableViewController }) as? DealResultsTableViewController {
         //   vc.selectedCards = self.selectedCards
            vc.selectedCards[indexPath!.row] = newSelection!
                
         
                
            vc.tableView.reloadData()
           // vc.tableView.beginUpdates()
           // vc.tableView.endUpdates()
        }
          
        } while  !selectionSuccess
    }
    
    
    
    @IBOutlet weak var dealResultsContainerView: UIView!
    
    
    @IBOutlet weak var holdButton: UIButton!
    
    

    
    /*
     weak var tableViewCellDelegate: DealResultsTableViewCellDelegate!
     weak var delegate: DealResultsViewController!
     */
    
    var finalCards: String = ""
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "FinalResultsSegue":
             let destinationController = segue.destination as! FinalResultViewController
             destinationController.finalDeck = selectedDeck!
             destinationController.finalCards = finalCards
             destinationController.container = container
            destinationController.selectedCards = selectedCards
        case "embeddedDealResultTableSegue":
            let destinationController = segue.destination as! DealResultsTableViewController
            destinationController.container = container
            
            let items = playGame()
            destinationController.selectedCards = items
            selectedCards = items
            
            destinationController.tableViewCellDelegate = self
       default:
            
            return
            
        }
        /*
        if segue.identifier == "FinalResultsSegue" {
            let destinationController = segue.destination as! FinalResultViewController
          
            // let indexPath = tableView.indexPathForSelectedRow!
           // commitDeckSelected = fetchedResultsController?.object(at: cardlistButtonIndexPath) as! Deck
            // print("testing")
            //    let selectedCards = commit.childCards
            destinationController.finalDeck = selectedDeck!
            destinationController.finalCards = finalCards
            
            
        }
 */
    }
    
    @IBAction func holdButtonTapped(_ sender: UIButton) {
        
        
        finalCards = ""
        
        for item in selectedCards {
            finalCards += "\(item.cardName!)\r"
            finalCardsData += "\(item.cardName!)  "

        
        }
        print(finalCards)
        performSegue(withIdentifier: "FinalResultsSegue", sender: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //   print("loaded")
        
        // Do any additional setup after loading the view.
    }
    
    
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
        if segue.identifier == "embeddedDealResultTableSegue" {
            let destinationController = segue.destination as! DealResultsTableViewController
            destinationController.container = container
            
            let items = playGame()
            destinationController.selectedCards = items
            selectedCards = items
            
            destinationController.tableViewCellDelegate = self
        }
    }
 */
    
    
    
    func playGame() -> [Card] {
        var selected: [Card] = []
        //1. use only cards that are inlcuded
        let fetchedCards = selectedDeck!.childCards!.allObjects as! [Card]
        let possibleCards = fetchedCards.filter {$0.cardIncluded == true}
        
        //2. pick cards until you have numberOfCardsToPick
        while selected.count < selectedDeck!.numberOfCardsToPick {
            let pick = possibleCards.randomElement()
            if !selected.contains(pick!) {
                selected.append(pick!)
            }
        }
        return selected
    }
    
    
    
}


/*
 if let indexPath  = sender.getIndexPath() {
 if let vc = self.children.first(where: { $0 is DealResultsTableViewController }) as? DealResultsTableViewController {
 
 vc.selectedCards[indexPath.row] =  vc.selectedCards[item]
 vc.tableView.beginUpdates()
 vc.tableView.endUpdates()
 }
 
 }
 */
