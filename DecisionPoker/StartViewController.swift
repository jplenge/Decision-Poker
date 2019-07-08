//
//  StartViewController.swift
//  DecisionPoker
//
//  Created by Jodi Szarko on 6/27/19.
//  Copyright © 2019 Jodi Szarko. All rights reserved.

// Note: This is the View Controller that controls the opening window. 

import UIKit
import CoreData

class StartViewController: UIViewController {
    
    var container: NSPersistentContainer!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    


        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "StartDealingSegue" {
                let controller = segue.destination as! DecksViewController
               // let controller = navigationContoller.viewControllers.first as! DecksViewController
                controller.container = container
            }
        }
    


}
