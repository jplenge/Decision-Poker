//
//  AppDelegate.swift
//  DecisionPoker
//
//  Created by Jodi Szarko on 6/27/19.
//  Copyright © 2019 Jodi Szarko. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func deleteAllData(entity: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results {
                if let managedObjectData:NSManagedObject = managedObject as? NSManagedObject {
                    managedContext.delete(managedObjectData)
                }
            }
        } catch let error as NSError {
            print("Delete all data in \(entity) error : \(error) \(error.userInfo)")
        }
    }
    
    func firstTimeDataBaseInit() {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        
        let cardRed = Card(context: context!)
        cardRed.cardName = NSLocalizedString("red", comment: "")
        cardRed.cardIncluded = true
        cardRed.cardComment = NSLocalizedString("""
            This is one of the color choices. Feel free to edit, delete and add additional comments here! If there is a color that you do not want to delete
            from yourlist, but you do not want to use it for your currentdecision, you can deselect this color using the slider to the right.
            """, comment: "")
        cardRed.cardInformation = false
        cardRed.cardsTablePosition = 0
        cardRed.id = UUID()
        
        let cardOrange = Card(context: context!)
        cardOrange.cardName = NSLocalizedString("orange", comment: "")
        cardOrange.cardIncluded = true
        cardOrange.cardComment = NSLocalizedString("""
            This is one of the color choices. Feel free to edit, delete  and add additional comments here! If there is a color that you do not want to delete
            from your list, but you do not want to use it for your current decision, you can deselect this color using the slider to the right.
            """, comment: "")
        cardOrange.cardInformation = false
        cardOrange.cardsTablePosition = 1
        cardOrange.id = UUID()
        
        let cardYellow = Card(context: context!)
        cardYellow.cardName = NSLocalizedString("yellow", comment: "")
        cardYellow.cardIncluded = true
        cardYellow.cardComment = NSLocalizedString("""
            This is one of the color choices. Feel free to edit, delete  and add additional comments here! If there is a color that you do not want to delete
            from your list, but you do not want to use it for your current decision, you can deselect this color using the slider to the right.
            """, comment: "")
        cardYellow.cardInformation = false
        cardYellow.cardsTablePosition = 2
        cardYellow.id = UUID()
        
        let cardGreen = Card(context: context!)
        cardGreen.cardName = NSLocalizedString("green", comment: "")
        cardGreen.cardIncluded = true
        cardGreen.cardComment = NSLocalizedString("""
            This is one of the color choices. Feel free to edit, delete  and add additional comments here! If there is a color that you do not want to delete
            from your list, but you do not want to use it for your current decision, you can deselect this color using the slider to the right.
            """, comment: "")
        cardGreen.cardInformation = false
        cardGreen.cardsTablePosition = 3
        cardGreen.id = UUID()
        
        let cardBlue = Card(context: context!)
        cardBlue.cardName = NSLocalizedString("blue", comment: "")
        cardBlue.cardIncluded = true
        cardBlue.cardComment = NSLocalizedString("""
            This is one of the color choices. Feel free to edit, delete  and add additional comments here! If there is a color that you do not want to delete
            from your list, but you do not want to use it for your current decision, you can deselect this color using the slider to the right.
            """, comment: "")
        cardBlue.cardInformation = false
        cardBlue.cardsTablePosition = 4
        cardBlue.id = UUID()
        
        let cardIndigo = Card(context: context!)
        cardIndigo.cardName = NSLocalizedString("indigo", comment: "")
        cardIndigo.cardIncluded = true
        cardIndigo.cardComment = NSLocalizedString("""
            This is one of the color choices. Feel free to edit, delete  and add additional comments here! If there is a color that you do not want to delete
            from your list, but you do not want to use it for your current decision, you can deselect this color using the slider to the right.
            """, comment: "")
        cardIndigo.cardInformation = false
        cardIndigo.cardsTablePosition = 5
        cardIndigo.id = UUID()
        
        let cardViolet = Card(context: context!)
        cardViolet.cardName = NSLocalizedString("violet", comment: "")
        cardViolet.cardIncluded = true
        cardViolet.cardComment = NSLocalizedString("""
            This is one of the color choices. Feel free to edit, delete  and add additional comments here! If there is a color that you do not want to delete
            from your list, but you do not want to use it for your current decision, you can deselect this color using the slider to the right.
            """, comment: "")
        cardViolet.cardInformation = false
        cardViolet.cardsTablePosition = 6
        cardViolet.id = UUID()
        
        let cardDishes = Card(context: context!)
        cardDishes.cardName = NSLocalizedString( "Do the dishes.", comment: "")
        cardDishes.cardIncluded = true
        cardDishes.cardComment = NSLocalizedString("""
            This is one of the chores in your to do list. Hopefully it's one that you don't mind doing. Feel free to add additional comments regarding this
            item here! If there is a chore that you do not want to delete from your list, but you do not want to use it for your current decision, you can
            deselect it using the slider to the right.
            """, comment: "")
        cardDishes.cardsTablePosition = 0
        cardDishes.id = UUID()
        
        let cardFloor = Card(context: context!)
        cardFloor.cardName = NSLocalizedString("Clean the floor.", comment: "")
        cardFloor.cardIncluded = true
        cardFloor.cardComment = NSLocalizedString("""
            This is one of the chores in your to do list. Hopefully it's one that you don't mind doing. Feel free to add additional comments regarding this
            item here! If there is a chore that you do not want to delete from your list, but you do not want to use it for your current decision, you can
            deselect it using the slider to the right.
            """, comment: "")
        cardFloor.cardInformation = false
        cardFloor.cardsTablePosition = 1
        cardFloor.id = UUID()
        
        let cardDust = Card(context: context!)
        cardDust.cardName = NSLocalizedString("Dust the livingroom.", comment: "")
        cardDust.cardIncluded = true
        cardDust.cardComment = NSLocalizedString("""
            This is one of the chores in your to do list. Hopefully it's one that you don't mind doing. Feel free to add additional comments regarding this
            item here! If there is a chore that you do not want to delete from your list, but you do not want to use it for your current decision, you can
            deselect it using the slider to the right.
            """, comment: "")
        cardDust.cardInformation = false
        cardDust.cardsTablePosition = 2
        cardDust.id = UUID()
        
        let cardDesk = Card(context: context!)
        cardDesk.cardName = NSLocalizedString( "Organize my desk.", comment: "")
        cardDesk.cardIncluded = true
        cardDesk.cardComment = NSLocalizedString("""
            This is one of the chores in your to do list. Hopefully it's one that you don't mind doing. Feel free to add additional comments regarding this
            item here! If there is a chore that you do not want to delete from your list, but you do not want to use it for your current decision, you can
            deselect it using the slider to the right.
            """, comment: "")
        cardDesk.cardInformation = false
        cardDesk.cardsTablePosition = 3
        cardDesk.id = UUID()
        
        let cardLaundry = Card(context: context!)
        cardLaundry.cardName = NSLocalizedString("Do the laundry.", comment: "")
        cardLaundry.cardIncluded = true
        cardLaundry.cardComment = NSLocalizedString("""
            This is one of the chores in your to do list. Hopefully it's one that you don't mind doing. Feel free to add additional comments regarding this
            item here! If there is a chore that you do not want to delete from your list, but you do not want to use it for your current decision, you can
            deselect it using the slider to the right.
            """, comment: "")
        cardLaundry.cardInformation = false
        cardLaundry.cardsTablePosition = 4
        cardLaundry.id = UUID()
        
        let choresDeck = Deck(context: context!)
        choresDeck.deckName = NSLocalizedString("Household Chores", comment: "")
        choresDeck.deckComment = NSLocalizedString("""
            Here are some typical household chores you might be in charge of. You can change the name of the deck if you want. Say you have five chores you
            would like to get done, but you can only get to two or three at the moment. Then let the app do the picking for you! In the default setup, your
            device will randomly choose 2 out of 5 chores. Add, delete, or deselect chores as you wish by pressing the \"Card List\" button. Change the number
            of choices using the stepper on the screen. Feel free to add additional comments about your deck here! If this is the topic you want to use to
            make a decision, hit the \"Deal!\" button above. If you would like to make a new deck, press the \"+\" button below and edit the deck as you
            would this one. Each deck has its own deal button, but only one deck is used at a time.
            """, comment: "")
        choresDeck.numberOfCardsToPick = 2
        choresDeck.dealButtonSelector = true
        choresDeck.decksTablePosition = 1
        choresDeck.id = UUID()
        
        let colorsDeck = Deck(context: context!)
        colorsDeck.deckName = NSLocalizedString("Colors", comment: "")
        colorsDeck.deckComment = NSLocalizedString("""
            Here are all the colors of the rainbow. We chose this as an example deck to show how to use this app. You can change the name of the deck if you
            want. If you (or your team) have a project that requires several colors, and you are not sure about which ones you want to use, let the app do the
            picking for you! In the default setup, your device will randomly choose 3 out of 7 colors. Add, delete, or deselect colors as you wish by pressing
            the \"Card List\" button. Change the number of choices using the stepper on the screen. Feel free to add additional comments about your deck here!
            If this is the topic you want to use to make a decision, hit the \"Deal!\" button above. If you would like to make a new deck, press the \"+\"
            button below and edit the deck as you would this one. Each deck has its own deal button, but only one deck is used at a time.
            """, comment: "")
        colorsDeck.numberOfCardsToPick = 3
        colorsDeck.dealButtonSelector = true
        colorsDeck.decksTablePosition = 0
        colorsDeck.id = UUID()
        
        choresDeck.addToChildCards(cardDishes)
        choresDeck.addToChildCards(cardFloor)
        choresDeck.addToChildCards(cardDust)
        choresDeck.addToChildCards(cardDesk)
        choresDeck.addToChildCards(cardLaundry)
        
        colorsDeck.addToChildCards(cardRed)
        colorsDeck.addToChildCards(cardOrange)
        colorsDeck.addToChildCards(cardYellow)
        colorsDeck.addToChildCards(cardGreen)
        colorsDeck.addToChildCards(cardBlue)
        colorsDeck.addToChildCards(cardIndigo)
        colorsDeck.addToChildCards(cardViolet)
        
        do {
            try context!.save()
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
        
    }
    
    func isAppAlreadyLaunchedOnce() -> Bool {
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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if !isAppAlreadyLaunchedOnce() {
            deleteAllData(entity: "Deck")
            deleteAllData(entity: "Card")
            firstTimeDataBaseInit()
            
            UserDefaults.standard.set(0, forKey: "SelectedTheme")
        } else {
            
            if UserDefaults.standard.object(forKey: "SelectedTHeme") == nil {
                UserDefaults.standard.set(0, forKey: "SelectedTheme")
            }
            
        }
        
        /*
         let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
         let mainVC = mainStoryboard.instantiateViewController(withIdentifier: "StartViewController") as! StartViewController
         self.window?.rootViewController = mainVC
         mainVC.container = persistentContainer
         */
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "DecisionPoker")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application,
                // although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
       
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application,
                // although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

// MARK: - Core Data stack

var persistentContainer: NSPersistentContainer = {
    /*
     The persistent container for the application. This implementation
     creates and returns a container, having loaded the store for the
     application to it. This property is optional since there are legitimate
     error conditions that could cause the creation of the store to fail.
     */
    let container = NSPersistentContainer(name: "DecisionPoker")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        if let error = error as NSError? {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application,
            // although it may be useful during development.
            
            /*
             Typical reasons for an error here include:
             * The parent directory does not exist, cannot be created, or disallows writing.
             * The persistent store is not accessible, due to permissions or data protection when the device is locked.
             * The device is out of space.
             * The store could not be migrated to the current model version.
             Check the error message to determine what the actual problem was.
             */
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    })
    return container
}()

// MARK: - Core Data Saving support

func saveContext () {
    let context = persistentContainer.viewContext
    if context.hasChanges {
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application,
            // although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
