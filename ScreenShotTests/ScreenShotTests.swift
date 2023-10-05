//
//  ScreenShotTests.swift
//  ScreenShotTests
//
//  Created by Jürgen Plenge on 07.07.23.
//  Copyright © 2023 Jodi Szarko. All rights reserved.
//

import XCTest

final class ScreenShotTests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        
        takeScreenshot(named: "Decks-01")
        
//        let collectionViewsQuery = app.collectionViews
//        collectionViewsQuery.children(matching: .cell).element(boundBy: 1).buttons[String(localized: "Deal")].tap()
//        print(String(localized: "Deal"))
//        sleep(2)
//        
//        takeScreenshot(named: "Decks-02")

        //        let app = XCUIApplication()
        //        app.collectionViews/*@START_MENU_TOKEN@*/.buttons["Total: 5 cards, Active: 5 cards, Select: 3 cards"]/*[[".cells.buttons[\"Total: 5 cards, Active: 5 cards, Select: 3 cards\"]",".buttons[\"Total: 5 cards, Active: 5 cards, Select: 3 cards\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        //        app.buttons["Hold 'em!"].tap()
        //        app.buttons["Save"].tap()

        //        // reset database
        //        app.tabBars["Tab-Leiste"].buttons["Einstellungen"].tap()
        //        app.buttons["Datenbank zurücksetzen"].tap()
        //        app.alerts["Vorsicht, damit werden alle Kartenstapel in der Datenbank gelöscht!"].scrollViews.otherElements.buttons["Ja, weiter"].tap()
        //
        //        snapshot("01Decks")
        //
        //        let collectionViewsQuery = app.collectionViews
        //        collectionViewsQuery.children(matching: .cell).element(boundBy: 2).buttons[localizedString(key: "Deal")].tap()
        //        takeScreenshot(named: "Decks-01")
        //
        //        app.buttons[localizedString(key: "Hold 'em!")].tap()
        //        snapshot("03Decks")
        //        app.buttons[localizedString(key: "Done")].tap()
        //
        //        collectionViewsQuery.children(matching: .cell).element(boundBy: 0).buttons[localizedString(key: "Deal")].tap()
        //        snapshot("04Decks")
        //
        //        app.buttons[localizedString(key: "Hold 'em!")].tap()
        //        snapshot("05Decks")
    }
    
    func localizedString(key:String) -> String {
        let localizationBundle = Bundle(for: ScreenShotTests.self)
        // handle "en-US" localisation
//        if let path = localizationBundle.path(forResource: deviceLanguage, ofType: "lproj") {
//            let deviceBundle = Bundle(path: path)
//            let result = NSLocalizedString(key, bundle: deviceBundle!, comment: "")
//            return result
//        }
        // handle "Base.lproj" localization
//        if let path = localizationBundle.path(forResource: "Base", ofType: "lproj") {
//            let deviceBundle = Bundle(path: path)
//            let result = NSLocalizedString(key, bundle: deviceBundle!, comment: "")
//            return result
//        }
        // handle "en" localization
        if let path = localizationBundle.path(forResource: NSLocale.current.language.languageCode?.identifier, ofType: "lproj") {
            let deviceBundle = Bundle(path: path)
            let result = NSLocalizedString(key, bundle: deviceBundle!, comment: "")
            return result
        }
        return "?"
    }
    
    func takeScreenshot(named name: String) {
        // Take the screenshot
        let fullScreenshot = XCUIScreen.main.screenshot()
        
        // Create a new attachment to save our screenshot
        // and give it a name consisting of the "named"
        // parameter and the device name, so we can find
        // it later.
        let screenshotAttachment = XCTAttachment(
            uniformTypeIdentifier: "public.png",
            name: "Screenshot-\(UIDevice.current.name)-\(name).png",
            payload: fullScreenshot.pngRepresentation,
            userInfo: nil)
        
        // Usually Xcode will delete attachments after
        // the test has run; we don't want that!
        screenshotAttachment.lifetime = .keepAlways
        
        // Add the attachment to the test log,
        // so we can retrieve it later
        add(screenshotAttachment)
    }
}
