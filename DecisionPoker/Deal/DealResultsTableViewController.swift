//
//  GoForwardNoContainerTableViewController.swift
//  PickerViewInTableInContainerView
//
//  Created by Jodi Szarko on 7/1/19.
//  Copyright © 2019 Jodi Szarko. All rights reserved.
//

import UIKit
import CoreData

class DealResultsTableViewController: UITableViewController  {
    

    weak var tableViewCellDelegate: DealResultsTableViewCellDelegate!
    weak var delegate: DealResultsViewController!
    
    var container: NSPersistentContainer!
    var selectedCards: [Card] = []
    weak var selectedDeck: Deck?
    
    var rowTouched: Int = -1
    var rowHeight: CGFloat = 80
    let normalCellHeight: CGFloat = 80
    //let largeCellHeight: CGFloat = 200
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        //let cellHeight = tableView.dequeueReusableCell(withIdentifier: "CardsCellIndentifier") as? CardsCell
        if indexPath.row == rowTouched {
            return rowHeight
        } else {
            return normalCellHeight
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       // return Int(selectedDeck!.numberOfCardsToPick)
        return selectedCards.count
    }
    
    /*
     override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     
     return 200
     }
     */
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DealResultsCell") as? DealResultsTableViewCell else{
            
            fatalError("Could not dequeueu cell")
        }
        
        //  let resultItemDisplay = listOfWords[indexPath.row]
        //  print("hello")
        
        
        //  cell.listPicker = listOfWords
        //cell.listButton.isOn = true
        let pdata =  selectedCards[indexPath.row].parentDeck!.childCards!.allObjects as! [Card]
        
        cell.resultItem.text = selectedCards[indexPath.row].cardName
        cell.pickerData = pdata.filter {$0.cardIncluded == true}
        cell.delegate = tableViewCellDelegate
       // cell.delegate = DealResultsTableViewCellDelegate

        
        
        // Configure the cell...
        
        return cell
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
    
   /* func playGame() -> [Card] {
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
    } */
    
}
