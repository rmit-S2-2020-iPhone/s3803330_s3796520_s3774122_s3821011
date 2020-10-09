//
//  TalesAndSpiritsUITests.swift
//  TalesAndSpiritsUITests
//
//  Created by GAJSA on 14/8/20.
//  Copyright © 2020 RMIT. All rights reserved.
//

import XCTest

class TalesAndSpiritsUITests: XCTestCase {

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

    func addFavouriteTest() {
        
        
        
    }

    func testExample() {
        
        let app = XCUIApplication()
        app.collectionViews.cells.otherElements.containing(.staticText, identifier:"747 Drink").element.tap()
        app.scrollViews.otherElements.buttons["Star"].tap()
        app.tabBars.buttons["My Diary"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["747 Drink"]/*[[".cells.staticTexts[\"747 Drink\"]",".staticTexts[\"747 Drink\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func addFavourite() {
        
    }

}
