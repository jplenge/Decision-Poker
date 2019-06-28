//
//  CardsCell.swift
//  DecisionPoker
//
//  Created by Jodi Szarko on 6/27/19.
//  Copyright © 2019 Jodi Szarko. All rights reserved.
//

import UIKit

protocol CardsCellDelegate: class {
    func CardIncluded(sender:CardsCell)
    func CardInfoTapped(sender: CardsCell)
    func SetHeight(sender: CardsCell)
    func CardCommentUpdate(sender:CardsCell, comment:String)
}


class CardsCell: UITableViewCell, UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        cardCommentIsUpdated(cardCommentText)
    }
    
    
    @IBOutlet weak var nameOfCard: UILabel!
    @IBOutlet weak var cardIsIncluded: UISwitch!
    @IBOutlet weak var cardInfo: UIButton!
    @IBOutlet weak var cardCommentText: UITextView!
    
   
    
    weak var delegate: CardsCellDelegate?
    

    
    @IBAction func cardIsIncludedTapped(_ sender: UISwitch) {
        delegate?.CardIncluded(sender: self)
    }
    
    let normalCellHeight: CGFloat = 40
    let largeCellHeight: CGFloat = 200
    
    @IBAction func cardInfoIsTapped(_ sender: UIButton) {
       
        delegate?.CardInfoTapped(sender: self)
        
    }
    
    func setCellHeight () -> CGFloat {
        delegate?.SetHeight(sender: self)
        
        switch cardInfo.isTouchInside {
        case true:
            return largeCellHeight
        default:
            return normalCellHeight
        }
    }
    
    
    func cardCommentIsUpdated(_ sender: UITextView) {
        delegate?.CardCommentUpdate(sender: self, comment: cardCommentText.text)
    }
        
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
         cardCommentText?.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
