//
//  DeveloperInfoUITest.swift
//  TalesAndSpiritsUITests
//
//  Created by GAJSA on 7/10/20.
//  Copyright © 2020 RMIT. All rights reserved.
//

import XCTest

class DeveloperInfoUITest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func developerInfoUITest() {
        
        let app = XCUIApplication()
        app.tabBars.buttons["More"].tap()
        
        let backgroundElement = app.scrollViews.otherElements.containing(.image, identifier:"Background").element
        backgroundElement.swipeUp()
        backgroundElement.swipeDown()
    }
}