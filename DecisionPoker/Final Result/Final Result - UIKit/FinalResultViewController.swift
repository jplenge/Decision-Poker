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
    
    var selectedCards: [Card]!
    
    var container: NSPersistentContainer!


    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBOutlet weak var finalResultDeck: UILabel!
    

    @IBOutlet weak var finalResultCards: UITextView!
    
    @IBAction func finalResultsShareButton(_ sender: Any) {
        displayShareSheet(shareContent: finalResultsData)
    }
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        finalResultDeck.text = "\(finalDeck.deckName!):"
        finalResultCards.text = finalCards
        formatFinalResult()
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SaveResultsSegue" {
           // let destinationController = segue.destination as! SavedResultsController
           // destinationController.container = container
            
            let navigationContoller = segue.destination as! UINavigationController
            let controller = navigationContoller.viewControllers.first as! SavedResultsController
            controller.container = container
            saveFinalDeck()
        }
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
        
        present(activityViewController, animated: true, completion: nil)
        if let popOver = activityViewController.popoverPresentationController {
            popOver.sourceView = self.view
            //popOver.sourceRect
            popOver.barButtonItem = shareButton
        }
        
    }
    
    
    
    
    func saveFinalDeck() {
        
        let managedContext = container.viewContext
        let newDeck = SavedDeck(context: managedContext)
        newDeck.deckName = finalDeck.deckName
        newDeck.deckComment =  finalDeck.deckComment
        newDeck.dateSaved = Date()
        
        for card in selectedCards{
            let newCard = SavedCard(context: managedContext)
            newCard.cardName = card.cardName
            newCard.cardComment = card.cardComment
            
            newDeck.addToSavedChildCards(newCard)
        }
        
        try! managedContext.save()
    }
    
    
}
