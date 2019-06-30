//
//  DecksCell.swift
//  DecisionPoker
//
//  Created by Jodi Szarko on 6/27/19.
//  Copyright © 2019 Jodi Szarko. All rights reserved.
//

import UIKit

protocol DecksCellDelegate: class {
    
    func DeckNameUpdate(sender: DecksCell, comment: String)
    func ChangeCardNumberTapped(sender: DecksCell)
    func DeckInfoTapped(sender: DecksCell)
    func SetHeightDeckTable(sender: DecksCell)
    func DealButtonTapped( sender: DecksCell)
    func CardlistButtonTapped( sender: DecksCell)
    func DeckCommentUpdate(sender:DecksCell, comment:String)

    
}
class DecksCell: UITableViewCell, UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        deckCommentIsUpdated(deckCommentText)
        deckNameIsUpdated(nameOfDeck)
    }

   
    
    @IBOutlet weak var nameOfDeck: UITextView!
    @IBOutlet weak var numberOfResults: UILabel!
    @IBOutlet weak var useableCardsInDeck: UILabel!
    @IBOutlet weak var resultsNumberChanged: UIStepper!
    @IBOutlet weak var dealButton: UIButton!
    @IBOutlet weak var deckInfo: UIButton!
    @IBOutlet weak var deckCommentText: UITextView!
    @IBOutlet weak var cardlistButton: UIButton!
    
    weak var delegate: DecksCellDelegate?

    @IBAction func resultsNumberChangedTapped(_ sender: UIStepper) {
        delegate?.ChangeCardNumberTapped(sender: self)
    }
    
    @IBAction func dealButtonIsTapped(_ sender: UIButton) {
        delegate?.DealButtonTapped(sender: self)
    }
    
    @IBAction func deckInfoIsTapped(_ sender: UIButton) {
        delegate?.DeckInfoTapped(sender: self)
    }
    
    
    @IBAction func cardlistButtonIsTapped(_ sender: UIButton) {
        delegate?.CardlistButtonTapped(sender: self)
    }
    
    
    let normalCellHeight: CGFloat = 100
    let largeCellHeight: CGFloat = 200
    

    
    func setDeckCellHeight () -> CGFloat {
        delegate?.SetHeightDeckTable(sender: self)
        
        switch deckInfo.isTouchInside {
        case true:
            return largeCellHeight
        default:
            return normalCellHeight
        }
    }
    func deckCommentIsUpdated(_ sender: UITextView) {
        delegate?.DeckCommentUpdate(sender: self, comment: deckCommentText.text)
    }
    
    func deckNameIsUpdated(_ sender: UITextView) {
        delegate?.DeckNameUpdate(sender: self, comment: nameOfDeck.text)
    }
    
    
   // @IBAction func deckButtonIsTapped(_ sender: UIButton) {
   //     delegate?.DeckButtonTapped(sender: self)

  //  }
    override func awakeFromNib() {
        super.awakeFromNib()
      
        deckCommentText?.delegate = self
        nameOfDeck?.delegate = self
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
