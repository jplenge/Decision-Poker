//
//  DecksCell.swift
//  DecisionPoker
//
//  Created by Jodi Szarko on 6/27/19.
//  Copyright © 2019 Jodi Szarko. All rights reserved.
//

/* Note: This is the Cell Controller that shows the "Decks," or the list of topics to choose decisions from.  The file has the following sections:
 
 1) protocol - defines functions for the Table View Cell
 2) table view functions - defines functions called in the protocol
 3) storyboard objects - defines linked graphics components in the cell
 4) variables- uesr defined variables and delegates used by the cell or the table view
 5) storyboard actions - defines actions performed by graphics components in the cell if they are not defined in section 2
 6) additional functions - defines functions created by the user but not called in the protocol
 7) cell functions - defines functions automatically defined in a cell class
 8) unused code - area for test code used previously in the file - it can be reused at a leter time if the program requires it.
 
 */

import UIKit
// SECTION 1 - PROTOCOL//
protocol DecksCellDelegate: class {
    
    func DeckNameUpdate(sender: DecksCell, comment: String)
    func ChangeCardNumberTapped(sender: DecksCell)
    func DeckInfoTapped(sender: DecksCell)
    func DealButtonTapped( sender: DecksCell)
    func CardlistButtonTapped( sender: DecksCell)
    func DeckCommentUpdate(sender:DecksCell, comment:String)
    
}
// END SECTION 1 - PROTOCOL//

class DecksCell: UITableViewCell, UITextViewDelegate, UITextFieldDelegate {
    
// SECTION 2 - TABLE VIEW FUNCTIONS //
    
    
    @IBAction func deckNameIsUpdated(_ sender: UITextField) {
        delegate?.DeckNameUpdate(sender: self, comment: nameOfDeck.text!)
    }
    
    @IBAction func resultsNumberChangedTapped(_ sender: UIStepper) {
        delegate?.ChangeCardNumberTapped(sender: self)
    }
    
    @IBAction func deckInfoIsTapped(_ sender: UIButton) {
        delegate?.DeckInfoTapped(sender: self)
    }
    
    
    @IBAction func dealButtonIsTapped(_ sender: UIButton) {
        delegate?.DealButtonTapped(sender: self)
    }
    
    @IBAction func cardlistButtonIsTapped(_ sender: UIButton) {
        delegate?.CardlistButtonTapped(sender: self)
    }
    
    
    
    func deckCommentIsUpdated(_ sender: UITextView) {
        delegate?.DeckCommentUpdate(sender: self, comment: deckCommentText.text)
    }
    
// END SECTION 2 - TABLE VIEW FUNCTIONS//
    
// SECTION 3 - STORYBOARD OBJECTS //
    

    @IBOutlet weak var nameOfDeck: UITextField!
    @IBOutlet weak var numberOfResults: UILabel!
    @IBOutlet weak var useableCardsInDeck: UILabel!
    @IBOutlet weak var resultsNumberChanged: UIStepper!
    @IBOutlet weak var dealButton: UIButton!
    @IBOutlet weak var deckInfo: UIButton!
    @IBOutlet weak var deckCommentText: UITextView!
    @IBOutlet weak var cardlistButton: UIButton!
    
//END SECTION 3 - STORYBOARD OBJECTS //
    
// SECTION 4 - VARIABLES //
    
    weak var delegate: DecksCellDelegate?

    
    let normalCellHeight: CGFloat = 105
    let largeCellHeight: CGFloat = 255
    
// END SECTION 4 - VARIABLES //
    
// SECTION 5 - STORYBOARD ACTIONS //
    
// END SECTION 5 - STORYBOARD ACTIONS //
    
// SECTION 6 - ADDITIONAL FUNCTIONS //
 
   
    func textViewDidEndEditing(_ textView: UITextView) {
        deckCommentIsUpdated(deckCommentText)
    }
    
    
// END SECTION 6 - ADDITIONAL FUNCTIONS //
    
// SECTION 7 - CELL FUNCTIONS //

    override func awakeFromNib() {
        super.awakeFromNib()
      
        deckCommentText?.delegate = self
        
        nameOfDeck?.delegate = self
        nameOfDeck.returnKeyType = .done
        
        
        cardlistButton.layer.borderColor = UIColor.white.cgColor
        dealButton.layer.borderColor = UIColor.white.cgColor


        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        deckNameIsUpdated(nameOfDeck)
        return true
    }

}

// END SECTION 7 - CELL FUNCTIONS //

// SECTION 8 - UNUSED CODE //

/*
 func setDeckCellHeight () -> CGFloat {
 delegate?.SetHeightDeckTable(sender: self)
 
 switch deckInfo.isTouchInside {
 case true:
 return largeCellHeight
 default:
 return normalCellHeight
 }
 }
 */

// END SECTION 8 - UNUSED CODE //
