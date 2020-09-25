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
    var selectedDeck: Deck?
    
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
    
    
    func RedrawTapped(sender: DealResultsTableViewCell) {
        let indexPath = sender.getIndexPath()
        
        var selectionSuccess = false
        
        var numberOfSelectableCards = 0
        
        
        for item in selectedDeck!.childCards?.allObjects as! [Card] {
            numberOfSelectableCards += Int(truncating: NSNumber(value: item.cardIncluded))
        }
        
        
        if selectedDeck!.numberOfCardsToPick < Int16(numberOfSelectableCards) {
            
            repeat {
                let newSelection = ((selectedCards[indexPath!.row].parentDeck?.childCards?.allObjects as! [Card]).filter {$0.cardIncluded == true}).randomElement()
                // print (newSelection)
                
                
                if !selectedCards.contains(newSelection!) {
                    selectedCards[indexPath!.row] = newSelection!
                    selectionSuccess = true
                }
                if let vc = self.children.first(where: { $0 is DealResultsTableViewController }) as? DealResultsTableViewController {
                    vc.selectedCards[indexPath!.row] = newSelection!
                    vc.tableView.reloadData()
                }
                
            } while  !selectionSuccess
            
        } else {
            let alertController = UIAlertController(title: NSLocalizedString("Redraw Not Possible", comment: ""), message: NSLocalizedString("You need to either a) increase the number of cards in the deck or b) decrease the number of card choices that will be in your hand!", comment: ""), preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) -> Void in })
            
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    
    
    
    @IBOutlet weak var dealResultsContainerView: UIView!
    
    
    @IBOutlet weak var holdButton: UIButton!

    
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
            
            //
            let items = playGame()
            
            destinationController.selectedCards = items
            selectedCards = items
            
            destinationController.tableViewCellDelegate = self
        default:
            
            return
            
        }
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
        
        holdButton.layer.borderColor = UIColor.white.cgColor
    }
    
    

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
