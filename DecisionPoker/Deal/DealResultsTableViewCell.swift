//
//  GoForwardNoContainerTableViewCell.swift
//  PickerViewInTableInContainerView
//
//  Created by Jodi Szarko on 7/1/19.
//  Copyright © 2019 Jodi Szarko. All rights reserved.
//

/* Note: This is the Cell Controller that shows the initial result of your randomly selected items. The results are also optionally changed in this window. The file has the following sections:
 
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
import CoreData

// SECTION 1 - PROTOCOL//
protocol DealResultsTableViewCellDelegate: class {
    func CheatTapped (sender: DealResultsTableViewCell)
    func RedrawTapped (sender: DealResultsTableViewCell)
    func PickerItemSelected (sender: DealResultsTableViewCell, item: Int)
    
}
// END SECTION 1 - PROTOCOL//


class DealResultsTableViewCell: UITableViewCell,UIPickerViewDataSource, UIPickerViewDelegate {
    
// SECTION 2- TABLE VIEW FUNCTIONS//
   
    @IBAction func cheatIsTapped(_ sender: UIButton) {
        
        delegate?.CheatTapped(sender: self)
        print("ct")
    }
    
    @IBAction func redrawIsTapped(_ sender: UIButton) {
        delegate?.RedrawTapped(sender: self)
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.PickerItemSelected(sender: self, item: row)
    }
    
// END SECTION 2- TABLE VIEW FUNCTIONS//

// SECTION 3- STORYBOARD OBJECTS//

    @IBOutlet weak var resultItem: UILabel!
    @IBOutlet weak var resultCheat: UIButton!
    @IBOutlet weak var resultRedraw: UIButton!
    @IBOutlet weak var listPicker: UIPickerView!
    
// END SECTION 3- STORYBOARD OBJECTS//

// SECTION 4- VARIABLES//

    
    var pickerData: [Card] = []
    
   // weak var tableViewCellDelegate: DealResultsTableViewCellDelegate?
   // weak var delegate: DealResultsViewController!
    
    weak var delegate: DealResultsTableViewCellDelegate!
    
// END SECTION 4- VARIABLES//

// SECTION 5- STORYBOARD ACTIONS//
    
// END SECTION 5- STORYBOARD ACTIONS//

// SECTION 6- ADDITIONAL FUNCTIONS//
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
       // print (pickerData.count)
        
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
       //print (row)
        
        return pickerData[row].cardName!
    }
    
    func getIndexPath() -> IndexPath? {
        guard let superView = self.superview as? UITableView else {
            print("superview is not a UITableView - getIndexPath")
            return nil
        }
        let indexPath = superView.indexPath(for: self)
        return indexPath
    }

// END SECTION 6- ADDITIONAL FUNCTIONS//

// SECTION 7- CELL FUNCTIONS//

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        listPicker.delegate  = self
        listPicker.dataSource = self
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
// END SECTION 7- CELL FUNCTIONS//

}


