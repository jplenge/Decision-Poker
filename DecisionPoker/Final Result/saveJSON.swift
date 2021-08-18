//
//  saveJSON.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 18.08.21.
//  Copyright © 2021 Jodi Szarko. All rights reserved.
//

import Foundation

func saveJSON<T: Codable>(named: String, object: T) {
    
    if let fileURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.de.ipomic.DecisionPoker")?.appendingPathComponent(named) {
        do {
            let encoder = try JSONEncoder().encode(object)
            try encoder.write(to: fileURL)
        } catch {
            print("JSONSave error of \(error)")
        }
    }
}
