//
//  XCTestCase+WaitForElement.swift
//  Test.GuiaBolsoUITests
//
//  Created by Leandro Romano on 30/06/19.
//  Copyright © 2019 Leandro Romano. All rights reserved.
//

import XCTest

extension XCTestCase {
    
    func waitForElementToAppear(_ element: XCUIElement) {
        let existsPredicate = NSPredicate(format: "exists == true")
        expectation(for: existsPredicate, evaluatedWith: element)
        waitForExpectations(timeout: 5)
    }
    
}
