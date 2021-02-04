//
//  ColorSetup.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 25.06.20.
//  Copyright © 2020 Jodi Szarko. All rights reserved.
//

import SwiftUI
import UIKit
import Combine

class ThemeManager {
    
    let themes = ["Classic", "Modern", "Dark"]
    
    // current color settings
    var currentBackgroundColor = ColorManager.ClassicGreen
    var currentBackgroundColorUI = ColorManager.ClassicGreenUI
    var currentButtonBackgroundColor =  Color.white
    
    // current font settings
    var currentFont = "Marker Felt"
    var currentTextColor = Color.white
    var currentTextColorUI = UIColor.white
    
    // radio button: unselected background color
    var unselectedRadioButtonBackgroundColor = Color.black.opacity(0.3)
    
    // section header
    var sectionHeaderColor = ColorManager.ClassicGreen
    
    // Start image
    
    var startImage = "StartImage-black"
    
    // color options
    var colorChoices = [ColorManager.ClassicGreen, ColorManager.ModernBlue, Color.black]
    var colorChoicesUI = [ColorManager.ClassicGreenUI, ColorManager.ModernBlueUI, UIColor.black]
    var textColorChoices = [Color.white, Color.white, Color.white]
    var textColorChoicesUI = [UIColor.white, UIColor.white, UIColor.white]
    var radioButtonBackgroundColorChoices = [Color.black.opacity(0.3), Color.black.opacity(0.3), Color.white.opacity(0.3)]
    var sectionHeaderColorChoices = [ColorManager.ClassicGreen, ColorManager.ModernBlue, Color.black]

    // font options
    var fontChoices = ["Marker Felt", "Helvetica Neue", "Helvetica Neue"]
    
    var startImageChoices = ["StartImage-black", "StartImage-black", "StartImage-white"]
}


var Theme = ThemeManager()
