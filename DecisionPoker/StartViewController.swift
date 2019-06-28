//
//  StartViewController.swift
//  DecisionPoker
//
//  Created by Jodi Szarko on 6/27/19.
//  Copyright © 2019 Jodi Szarko. All rights reserved.
//

import UIKit
import CoreData

class StartViewController: UIViewController {
    
    var container: NSPersistentContainer!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel(seque: UIStoryboardSegue) {
    }

        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "StartDealingSegue" {
                let navigationContoller = segue.destination as! UINavigationController
                let controller = navigationContoller.viewControllers.first as! DecksViewController
                controller.container = container
            }
        }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
