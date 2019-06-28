//
//  DecksCell.swift
//  DecisionPoker
//
//  Created by Jodi Szarko on 6/27/19.
//  Copyright © 2019 Jodi Szarko. All rights reserved.
//

import UIKit

protocol DecksCellDelegate: class {
    
    func ChangeCardNumberTapped(sender: DecksCell)
    //func DeckButtonTapped( sender: DecksCell)
    func DealButtonTapped( sender: DecksCell)

    
}
class DecksCell: UITableViewCell {

   
    @IBOutlet weak var nameOfDeck: UILabel!
    @IBOutlet weak var numberOfResults: UILabel!
    @IBOutlet weak var useableCardsInDeck: UILabel!
    @IBOutlet weak var resultsNumberChanged: UIStepper!
    @IBOutlet weak var dealButton: UIButton!
    
    weak var delegate: DecksCellDelegate?

    @IBAction func resultsNumberChangedTapped(_ sender: UIStepper) {
        delegate?.ChangeCardNumberTapped(sender: self)
    }
    
    @IBAction func dealButtonIsTapped(_ sender: UIButton) {
        delegate?.DealButtonTapped(sender: self)
    }
    
   // @IBAction func deckButtonIsTapped(_ sender: UIButton) {
   //     delegate?.DeckButtonTapped(sender: self)

  //  }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
