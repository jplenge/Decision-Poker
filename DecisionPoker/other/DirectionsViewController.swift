//
//  DirectionsViewController.swift
//  DecisionPoker
//
//  Created by Jodi Szarko on 7/9/19.
//  Copyright © 2019 Jodi Szarko. All rights reserved.
//

import UIKit
import CoreData

class DirectionsViewController: UIViewController {

    var container: NSPersistentContainer!
    
    @IBOutlet weak var directionsLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            
        case "DirectionsDoneSegue":
            
            //let controller = segue.destination as! DecksViewController
            
            let navigationContoller = segue.destination as! UINavigationController
            let controller = navigationContoller.viewControllers.first as! StartViewController
            controller.container = container
        default:
            return
            
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
