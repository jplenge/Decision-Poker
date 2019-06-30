//
//  ResultsCell.swift
//  DecisionPoker
//
//  Created by Jodi Szarko on 6/30/19.
//  Copyright © 2019 Jodi Szarko. All rights reserved.
//

import UIKit

protocol ResultsCellDelegate: class {
    func CheatTapped (sender: ResultsCell)
    func RedrawTapped (sender: ResultsCell)
}

class ResultsCell: UITableViewCell {
    
    @IBOutlet weak var resultItem: UILabel!
    
    @IBOutlet weak var resultCheat: UIButton!
    
    @IBOutlet weak var resultRedraw: UIButton!
    
    weak var delegate: ResultsCellDelegate?
    
    @IBAction func resultsCheatTapped(_ sender: UIButton) {
        delegate?.CheatTapped(sender: self)
    }
    
    @IBAction func resultsRedrawTapped(_ sender: UIButton) {
        delegate?.RedrawTapped(sender: self)

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
