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
        app.launch()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testiPhoneScreenshots() throws {
        
        takeScreenshot(named: "Decks-01")
        
        let dealButton = app.collectionViews.children(matching: .cell).element(boundBy: 0).buttons["deal.btn"].buttons.element(boundBy: 1)
        dealButton.tap()
        sleep(3)
        takeScreenshot(named: "Decks-02")
        
        app.buttons["hold.btn"].tap()
        sleep(3)
        takeScreenshot(named: "Decks-03")
        
        app.buttons["done.btn"].tap()
        sleep(3)
        takeScreenshot(named: "Decks-04")
        
        app.tabBars.firstMatch.buttons["settings.btn"].tap()
        sleep(3)
        takeScreenshot(named: "Decks-05")
    }
    
    func iPadScreenshots() throws {
        
        takeScreenshot(named: "Decks-01")
        
        app.collectionViews.descendants(matching: .button).element(boundBy: 8).tap()
        sleep(3)
        takeScreenshot(named: "Decks-02")
        
        app/*@START_MENU_TOKEN@*/.buttons["hold.btn"]/*[[".buttons[\"Hold 'em!\"]",".buttons[\"hold.btn\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        sleep(3)
        takeScreenshot(named: "Decks-03")
        
        app/*@START_MENU_TOKEN@*/.buttons["done.btn"]/*[[".buttons[\"Done\"]",".buttons[\"done.btn\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        sleep(3)
        takeScreenshot(named: "Decks-04")
        
        app.collectionViews.descendants(matching: .button).element(boundBy: 2).tap()
        sleep(3)
        takeScreenshot(named: "Decks-05")
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
