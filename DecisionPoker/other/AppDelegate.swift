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

    func deleteAllData(entity: String)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Delete all data in \(entity) error : \(error) \(error.userInfo)")
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       
        deleteAllData(entity: "Deck")
        deleteAllData(entity: "Card")
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
    
        // let container: NSPersistentContainer!
        let context = appDelegate?.persistentContainer.viewContext
        
        let cardRed = Card(context: context!)
        cardRed.cardName = "red"
        cardRed.cardIncluded = true
        cardRed.cardComment = "This is one of the color choices. Feel free to add additional comments here!"
        cardRed.cardInformation = false
        cardRed.cardsTablePosition = 0
        
        let cardOrange = Card(context: context!)
        cardOrange.cardName = "orange"
        cardOrange.cardIncluded = true
        cardOrange.cardComment = "This is one of the color choices. Feel free to add additional comments here!"
        cardOrange.cardInformation = false
        cardOrange.cardsTablePosition = 1

        
        let cardYellow = Card(context: context!)
        cardYellow.cardName = "yellow"
        cardYellow.cardIncluded = true
        cardYellow.cardComment = "This is one of the color choices. Feel free to add additional comments here!"
        cardYellow.cardInformation = false
        cardYellow.cardsTablePosition = 2

        
        let cardGreen = Card(context: context!)
        cardGreen.cardName = "green"
        cardGreen.cardIncluded = true
        cardGreen.cardComment = "This is one of the color choices. Feel free to add additional comments here!"
        cardGreen.cardInformation = false
        cardGreen.cardsTablePosition = 3

        
        let cardBlue = Card(context: context!)
        cardBlue.cardName = "blue"
        cardBlue.cardIncluded = true
        cardBlue.cardComment = "This is one of the color choices. Feel free to add additional comments here!"
        cardBlue.cardInformation = false
        cardBlue.cardsTablePosition = 4

        
        let cardIndigo = Card(context: context!)
        cardIndigo.cardName = "indigo"
        cardIndigo.cardIncluded = true
        cardIndigo.cardComment = "This is one of the color choices. Feel free to add additional comments here!"
        cardIndigo.cardInformation = false
        cardIndigo.cardsTablePosition = 5

        
        let cardViolet = Card(context: context!)
        cardViolet.cardName = "violet"
        cardViolet.cardIncluded = true
        cardViolet.cardComment = "This is one of the color choices. Feel free to add additional comments here!"
        cardViolet.cardInformation = false
        cardViolet.cardsTablePosition = 6

        
        let cardDishes = Card(context: context!)
        cardDishes.cardName = "Do the dishes."
        cardDishes.cardIncluded = true
        cardDishes.cardComment = "This is one of the chores in your to do list. Hopefully it's one that you don't mind doing. Feel free to add additional comments here!"
        cardDishes.cardsTablePosition = 0

        
        let cardFloor = Card(context: context!)
        cardFloor.cardName = "Clean the floor."
        cardFloor.cardIncluded = true
        cardFloor.cardComment = "This is one of the chores in your to do list. Hopefully it's one that you don't mind doing. Feel free to add additional comments here!"
        cardFloor.cardInformation = false
        cardFloor.cardsTablePosition = 1

        
        let cardDust = Card(context: context!)
        cardDust.cardName = "Dust the livingroom."
        cardDust.cardIncluded = true
        cardDust.cardComment = "This is one of the chores in your to do list. Hopefully it's one that you don't mind doing. Feel free to add additional comments here!"
        cardDust.cardInformation = false
        cardDust.cardsTablePosition = 2

        
        
        let cardDesk = Card(context: context!)
        cardDesk.cardName = "Organize my desk."
        cardDesk.cardIncluded = true
        cardDesk.cardComment = "This is one of the chores in your to do list. Hopefully it's one that you don't mind doing. Feel free to add additional comments here!"
        cardDesk.cardInformation = false
        cardDesk.cardsTablePosition = 3


        
        let cardLaundry = Card(context: context!)
        cardLaundry.cardName = "Do the laundry."
        cardLaundry.cardIncluded = true
        cardLaundry.cardComment = "This is one of the chores in your to do list. Hopefully it's one that you don't mind doing. Feel free to add additional comments here!"
        cardLaundry.cardInformation = false
        cardLaundry.cardsTablePosition = 4


        
        let choresDeck = Deck(context: context!)
        choresDeck.deckName = "Household Chores"
        choresDeck.deckComment = "Here are some typical household chores you might be in charge of. Say you have fice chores you would like to get done, but you can only get to two or three at the moment. Then let the app do the picking for you! Add and delete chores as you wish. Feel free to add additional comments here!"
        choresDeck.numberOfCardsToPick = 2
        choresDeck.dealButtonSelector = true
        choresDeck.decksTablePosition = 1
        
        let colorsDeck = Deck(context: context!)
        colorsDeck.deckName = "Colors"
        colorsDeck.deckComment = "Here are all the colors of the rainbow. We chose this as an example deck to shoe how to use this app. If you (or your team) have a project that requires several colors, and you are not sure about which ones you want to use, let the app do the picking for you! Add and delete colors as you wish. Feel free to add additional comments here!"
        colorsDeck.numberOfCardsToPick = 3
        colorsDeck.dealButtonSelector = true
        colorsDeck.decksTablePosition = 0
        

        
   
        
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
        
        let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = mainStoryboard.instantiateViewController(withIdentifier: "StartViewController") as! StartViewController
        self.window?.rootViewController = mainVC
        
        mainVC.container = persistentContainer


        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
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
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
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
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

