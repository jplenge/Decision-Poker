//
//  ColorManager.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 01.11.20.
//  Copyright © 2020 Jodi Szarko. All rights reserved.
//

import SwiftUI
import UIKit
import Foundation

struct ThemeColor {
    let colors: [Color] = [
        Color("ClassicGreen"),
        Color("ModernBlue"),
            .red,
            .brown,
            .yellow,
            .green,
            .mint,
            .cyan,
            .blue,
            .purple,
            .indigo
        ]
}

let themeColor = ThemeColor()

//struct ColorManager {
//    static let ClassicGreen = Color("ClassicGreen")
//    static let ClassicGreenUI = UIColor(named: "ClassicGreen")
//    static let ModernBlue = Color("ModernBlue")
//    static let ModernBlueUI = UIColor(named: "ModernBlue")
//    static let TextColorLight = Color("TextColorLight")
//    static let TextColorLightUI = UIColor(named: "TextColorLight")
//}

// This does not seem to work
// extension Color: RawRepresentable {
//
//    public init?(rawValue: String) {
//
//        guard let data = Data(base64Encoded: rawValue) else {
//            self = .black
//            return
//        }
//
//        do {
//            let color = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data)
//            self = Color(color ?? .black)
//        } catch {
//            fatalError("Can't unarchive data: \(error)")
//            self = .black
//        }
//    }
//
//    public var rawValue: String {
//
//        do {
//            let data = try NSKeyedArchiver.archivedData(withRootObject: UIColor(self), requiringSecureCoding: false) as Data
//            return data.base64EncodedString()
//
//        } catch {
//            fatalError("Can't archive data: \(error)")
//            return ""
//        }
//    }
// }
