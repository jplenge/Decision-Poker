//
//  StartViewController.swift
//  DecisionPoker
//
//  Created by Jodi Szarko on 6/27/19.
//  Copyright © 2019 Jodi Szarko. All rights reserved.

// Note: This is the View Controller that controls the opening window. 

import UIKit
import CoreData
import MessageUI

class StartViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet var appTitle: UILabel!
    
    
    @IBAction func contactUs(_ sender: Any) {
        sendEmail()
    }
    
    
    
    var container: NSPersistentContainer!

    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.view.backgroundColor = UIColor(red: 0.0, green: 1.00, blue: 0.0, alpha: 0.35)
        
       // appTitle.minimumScaleFactor = 0.01
       // appTitle.adjustsFontSizeToFitWidth = true
       // appTitle.lineBreakMode = .byClipping
        appTitle.numberOfLines = 1


    }
    


        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            switch segue.identifier {
            
            case "StartDealingSegue":
            
            //let controller = segue.destination as! DecksViewController

                let navigationContoller = segue.destination as! UINavigationController
                let controller = navigationContoller.viewControllers.first as! DecksViewController
                controller.container = container
            case "DirectionsSegue":
                
                let navigationContoller = segue.destination as! UINavigationController
                let controller = navigationContoller.viewControllers.first as! DirectionsViewController
                controller.container = container
            default:
                return
            
        }
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["mail@ipomic.de"])
            mail.setSubject("Decision Poker:")
            //mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            // feedback to the user
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result.rawValue {
        case MFMailComposeResult.cancelled.rawValue:
            print("Cancelled")
        case MFMailComposeResult.saved.rawValue:
            print("Saved")
        case MFMailComposeResult.sent.rawValue:
            print("Sent")
        case MFMailComposeResult.failed.rawValue:
            print("Error: \(String(describing: error?.localizedDescription))")
        default:
            break
        }
        controller.dismiss(animated: true, completion: nil)
    }
    


}
