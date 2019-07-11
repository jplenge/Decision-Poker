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
    
    func changeFontName()
    {
        self.font = UIFont(name: "Marker Felt", size: self.font.pointSize)
        
        print (self.font.pointSize)
    }
}

extension UIButton {
    override open func awakeFromNib() {
        super.awakeFromNib()
        changeFontNameButton()
    }
    
    func changeFontNameButton()
    {
        self.titleLabel?.font = UIFont(name: "Marker Felt", size: 20)

        //print (self.font.pointSize)
    }
}

extension UITextView {
    override open func awakeFromNib() {
        super.awakeFromNib()
        changeFontNameView()
    }
    
    func changeFontNameView()
    {
        self.font = UIFont(name: "Marker Felt", size: (self.font?.pointSize)!)
        
        print ((self.font?.pointSize)!)
    }
}


