//
//  SavedResultsCell.swift
//  DecisionPoker
//
//  Created by Jodi Szarko on 7/8/19.
//  Copyright © 2019 Jodi Szarko. All rights reserved.
//

import UIKit

class SavedResultsCell: UITableViewCell {

    @IBOutlet var savedResultDate: UILabel!
    
    @IBOutlet var savedREsultDeckname: UILabel!
    
    @IBOutlet weak var savedResultCards: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
