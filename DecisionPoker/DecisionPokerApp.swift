//
//  DecisionPokerApp.swift
//  DecisionPoker
//
//  Created by Jürgen Plenge on 23.05.23.
//  Copyright © 2023 Jodi Szarko. All rights reserved.
//
import SwiftUI
import CoreData

@main
struct DecisionPokerApp: App {
    let persistenceController = PersistenceController.shared
    
    init() {
        if !isAppAlreadyLaunchedOnce() {
            resetDatabase()
        }
        
        // check if lastDecision json file exists
        if let fileURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.de.ipomic.DecisionPoker")?.appendingPathComponent("lastDecision") {
            
            if !FileManager.default.fileExists(atPath: fileURL.path) {
                let status = "No decision made"
                let lastDecision = Decision(deckname: status, date: Date(), selectedCards: [])
                saveJSON(named: "lastDecision", object: lastDecision)
            }
        } else {
            print("Error: can not create json file on startup")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

private func isAppAlreadyLaunchedOnce() -> Bool {
    let defaults = UserDefaults.standard
    
    if let isAppAlreadyLaunchedOnce = defaults.string(forKey: "isAppAlreadyLaunchedOnce") {
        print("App already launched : \(isAppAlreadyLaunchedOnce)")
        return true
    } else {
        defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
        print("App launched first time")
        return false
    }
}
