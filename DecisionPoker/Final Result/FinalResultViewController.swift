//
//  FinalResultViewController.swift
//  DecisionPoker
//
//  Created by Jodi Szarko on 7/7/19.
//  Copyright © 2019 Jodi Szarko. All rights reserved.
//

import UIKit
import CoreData

class FinalResultViewController: UIViewController {
    
    var finalDeck: Deck!
    var finalCards: String = ""
    var finalResultsData: String = ""

    
    @IBOutlet weak var finalResultDeck: UILabel!
    
    @IBOutlet weak var finalResultCards: UILabel!
    
    @IBAction func finalResultsShareButton(_ sender: Any) {
        displayShareSheet(shareContent: finalResultsData)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        finalResultDeck.text = finalDeck.deckName
        finalResultCards.text = finalCards
        formatFinalResult()
        
    }
    
    
    func formatFinalResult() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let now = Date()
        let dateString = formatter.string(from:now)
        
        finalResultsData = "\(dateString)\rDECK: \r\(selectedDeck.deckName!) \rCARDS: \r\(finalCards)"
    }
    
    
    func displayShareSheet(shareContent:String) {
        let activityViewController = UIActivityViewController(activityItems: [shareContent as NSString], applicationActivities: nil)
        present(activityViewController, animated: true, completion: {})
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier  == "SaveResultsSegue" {
            let destinationController = segue.destination as! SavedResultsController
            //destinationController.finalDeck = finalDeck
        }
        
        
    func saveDeck
    

    
}
