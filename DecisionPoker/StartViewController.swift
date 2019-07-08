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
        //  self.view.backgroundColor = UIColor(red: 0.0, green: 1.00, blue: 0.0, alpha: 0.35)
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StartDealingSegue" {
            let navigationContoller = segue.destination as! UINavigationController
            let controller = navigationContoller.viewControllers.first as! DecksViewController
            controller.container = container
        }
    }
    
    
}
