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
        
        self.minimumScaleFactor = 0.01
        self.adjustsFontSizeToFitWidth = true
        self.lineBreakMode = .byClipping
        
        //print (self.font.pointSize)
    }
}

extension UIButton {
    override open func awakeFromNib() {
        super.awakeFromNib()
        changeFontNameButton()
    }
    
    func changeFontNameButton()
    {
        self.titleLabel?.font = UIFont(name: "Marker Felt", size: self.titleLabel!.font.pointSize)
        
        self.contentScaleFactor = 0.01
        self.titleLabel?.adjustsFontSizeToFitWidth = true
     //   self.lineBreakMode = .byClipping
        self.titleLabel?.numberOfLines = 1

    }
    
}

//UIBarButtonItem.appearance()
 //   .setTitleTextAttributes([NSFontAttributeName: UIFont(name: "FontName-Regular", size: 14.0)!],
//                            for: .normal)

/*
 extension UINavigationItem {
    override open func awakeFromNib() {
        super.awakeFromNib()
        changeFontNameNavigationItem()
    }
    
    func changeFontNameNavigationItem()
    {
        self.set ([NSAttributedString.Key.font: UIFont (name: "Marker Felt", size: 20.0)!], for: UIControl.State.normal)

        
    }
    
}
 */

/*
extension UINavigationBar {
    override open func awakeFromNib() {
        super.awakeFromNib()
        changeFontNameNavigationItem()
    }
    
    func changeFontNameNavigationItem()
    {
        self.titleTextAttributes([NSFontAttributeName: UIFont(name: "Marker Felt", size: 16)!])
        
        
    }
    
}
*/
extension UITextView {
    override open func awakeFromNib() {
        super.awakeFromNib()
        changeFontNameView()
    }
    
    func changeFontNameView()
    {
        self.font = UIFont(name: "Marker Felt", size: (self.font?.pointSize)!)
        
        
       // print ((self.font?.pointSize)!)
    }
    
   
}


