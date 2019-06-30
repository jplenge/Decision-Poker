//
//  ResultsViewController.swift
//  DecisionPoker
//
//  Created by Jodi Szarko on 6/30/19.
//  Copyright © 2019 Jodi Szarko. All rights reserved.
//

import UIKit
import CoreData


class ResultsViewController: UIViewController {
    
    
    var container: NSPersistentContainer!
    weak var selectedDeck: Deck?
 
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationController = segue.destination as! ResultsTableViewController
        destinationController.container = container
        destinationController.selectedDeck = selectedDeck!
    }

}
