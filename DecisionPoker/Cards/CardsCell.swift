//
//  CardsCell.swift
//  DecisionPoker
//
//  Created by Jodi Szarko on 6/27/19.
//  Copyright © 2019 Jodi Szarko. All rights reserved.
//
/* Note: This is the Cell Controller that shows the "Cards," or the individual items to chose from to create the result.  The file has the following sections:
 
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
protocol CardsCellDelegate: class {
    
    func CardIncluded(sender:CardsCell)
    func CardNameUpdate(sender:CardsCell, comment:String)
    func CardInfoTapped(sender: CardsCell)
  //  func SetHeightCardTable(sender: CardsCell)
    func CardCommentUpdate(sender:CardsCell, comment:String)
}
// END SECTION 1 - PROTOCOL//


class CardsCell: UITableViewCell, UITextViewDelegate {

// SECTION 2 - TABLE VIEW FUNCTIONS//

    @IBAction func cardIsIncludedTapped(_ sender: UISwitch) {
        delegate?.CardIncluded(sender: self)
    }
    
    func cardNameIsUpdated(_ sender: UITextView) {
        delegate?.CardNameUpdate(sender: self, comment: nameOfCard.text)
    }
    
    @IBAction func cardInfoIsTapped(_ sender: UIButton) {
        
        delegate?.CardInfoTapped(sender: self)
        
    }
    
    func cardCommentIsUpdated(_ sender: UITextView) {
        delegate?.CardCommentUpdate(sender: self, comment: cardCommentText.text)
    }
    
// END SECTION 2 - TABLE VIEW FUNCTIONS//

// SECTION 3 - STORYBOARD OBJECTS//

    @IBOutlet weak var nameOfCard: UITextView!
    @IBOutlet weak var cardIsIncluded: UISwitch!
    @IBOutlet weak var cardInfo: UIButton!
    @IBOutlet weak var cardCommentText: UITextView!
    
// END SECTION 3 - STORYBOARD OBJECTS//

// SECTION 4 - VARIABLES//

    weak var delegate: CardsCellDelegate?
    
    let normalCellHeight: CGFloat = 40
    let largeCellHeight: CGFloat = 200
    
// END SECTION 4 - VARIABLES//

// SECTION 5 - STORYBOARD ACTIONS//
    
// END SECTION 5 - STORYBOARD ACTIONS//

// SECTION 6 - ADDITIONAL FUNCTIONS//

    func textViewDidEndEditing(_ textView: UITextView) {
        cardCommentIsUpdated(cardCommentText)
        cardNameIsUpdated(nameOfCard)
    }

// END SECTION 6 - ADDITIONAL FUNCTIONS//

// SECTION 7 - CELL FUNCTIONS//

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
         cardCommentText?.delegate = self
        nameOfCard?.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
// END SECTION 7 - CELL FUNCTIONS//


}

// SECTION 8 - UNUSED CODE//

// @IBAction func cardNameSavedIsTapped(_ sender: UIButton) {

//      delegate?.CardNameSavedTapped(sender: self)
//  }


/*
 func setCardCellHeight () -> CGFloat {
 delegate?.SetHeightCardTable(sender: self)
 
 switch cardInfo.isTouchInside {
 case true:
 return largeCellHeight
 default:
 return normalCellHeight
 }
 }
 */

// END SECTION 8 - UNUSED CODE//

