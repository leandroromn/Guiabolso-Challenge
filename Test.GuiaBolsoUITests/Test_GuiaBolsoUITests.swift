//
//  Test_GuiaBolsoUITests.swift
//  Test.GuiaBolsoUITests
//
//  Created by Leandro Romano on 27/06/19.
//  Copyright © 2019 Leandro Romano. All rights reserved.
//

import XCTest

class Test_GuiaBolsoUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    func testNumberOfCategoryCells() {
        let app = XCUIApplication()
        waitForElementToAppear(app.tables.cells.firstMatch)
        
        // The Chuck Norris categories endpoint always returns 16 items:
        let cellsCount = app.tables.cells.count
        XCTAssertEqual(cellsCount, 16)
    }
    
    func testJokeViewDisplayElements() {
        let app = XCUIApplication()
        waitForElementToAppear(app.tables.cells.firstMatch)
        
        let devCategoryCell = app.tables.staticTexts["Dev"]
        XCTAssertTrue(devCategoryCell.exists)
        devCategoryCell.tap()
        
        let avatarElement = app.images[JokeAccessibilityIdentifier.chuckNorrisAvatarImage.rawValue]
        let phraseElement = app.staticTexts[JokeAccessibilityIdentifier.chuckNorrisRandomJokePhrase.rawValue]
        let buttonElement = app.buttons[JokeAccessibilityIdentifier.chuckNorrisButtonToJokePage.rawValue]
        
        waitForElementToAppear(avatarElement)
        
        XCTAssertTrue(avatarElement.exists)
        XCTAssertTrue(phraseElement.exists)
        XCTAssertTrue(buttonElement.exists)
    }

}
