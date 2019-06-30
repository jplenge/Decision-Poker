//
//  ResultsTableViewController.swift
//  DecisionPoker
//
//  Created by Jodi Szarko on 6/30/19.
//  Copyright © 2019 Jodi Szarko. All rights reserved.
//

import UIKit
import CoreData

class ResultsTableViewController: FetchedResultsTableViewController, ResultsCellDelegate {
    
    func CheatTapped(sender: ResultsCell) {
        
        if let indexPath = tableView.indexPath(for: sender) {
            selectedCards[indexPath.row] = (selectedCards[indexPath.row].parentDeck?.childCards?.allObjects as! [Card]).randomElement()!
            
            tableView.reloadData()
        }
        
    }
    
    func RedrawTapped(sender: ResultsCell) {
        
    }
    
    var container: NSPersistentContainer!
    weak var selectedDeck: Deck?
    var selectedCards: [Card] = []
    
    func playGame() {
        
        //1. use only cards that are inlcuded
        let fetchedCards = selectedDeck!.childCards!.allObjects as! [Card]
        let possibleCards = fetchedCards.filter {$0.cardIncluded == true}
        
        //2. pick cards until you have numberOfCardsToPick
        while selectedCards.count < selectedDeck!.numberOfCardsToPick {
            let pick = possibleCards.randomElement()
            if !selectedCards.contains(pick!) {
                selectedCards.append(pick!)
            }
        }
    
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playGame() 

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return selectedCards.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultsCellIdentifier", for: indexPath) as! ResultsCell
        
        cell.resultItem.text = selectedCards[indexPath.row].cardName
        
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

}
