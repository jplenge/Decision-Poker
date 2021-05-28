//
//  FontSetup.swift
//  DecisionPoker
//
//  Created by Jodi Szarko on 7/11/19.
//  Copyright © 2019 Jodi Szarko. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    override open func awakeFromNib() {
        super.awakeFromNib()
        changeFontName()
    }
    
    func changeFontName() {
        self.font = UIFont(name: "Marker Felt", size: self.font.pointSize)
        self.minimumScaleFactor = 0.01
        self.adjustsFontSizeToFitWidth = true
        self.lineBreakMode = .byClipping
    }
}

extension UIButton {
    override open func awakeFromNib() {
        super.awakeFromNib()
        changeFontNameButton()
    }
    
    func changeFontNameButton() {
        self.titleLabel?.font = UIFont(name: "Marker Felt", size: self.titleLabel!.font.pointSize)
        self.contentScaleFactor = 0.01
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.titleLabel?.numberOfLines = 1
    }
    
}

extension UITextView {
    override open func awakeFromNib() {
        super.awakeFromNib()
        changeFontNameView()
    }
    
    func changeFontNameView() {
        self.font = UIFont(name: "Marker Felt", size: (self.font?.pointSize)!)
    }
}

extension UITextField {
    override open func awakeFromNib() {
        super.awakeFromNib()
        changeFontNameField()
    }
    
    func changeFontNameField() {
        self.font = UIFont(name: "Marker Felt", size: (self.font?.pointSize)!)
        self.contentScaleFactor = 0.01
        self.adjustsFontSizeToFitWidth = true
    }
}
