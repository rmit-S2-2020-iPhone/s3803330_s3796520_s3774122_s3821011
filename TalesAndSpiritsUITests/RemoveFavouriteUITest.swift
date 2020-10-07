//
//  RemoveFavouriteUITest.swift
//  TalesAndSpiritsUITests
//
//  Created by PUJA on 7/10/20.
//  Copyright © 2020 RMIT. All rights reserved.
//

import XCTest

class RemoveFavouriteUITest: XCTestCase {

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

    func removeFavouriteUITest() {
        
        let app = XCUIApplication()
        app.collectionViews.cells.otherElements.containing(.staticText, identifier:"A1").element.swipeUp()
        
        let starButton = app.scrollViews.otherElements.buttons["Star"]
        starButton.tap()
        app.tabBars.buttons["My Diary"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["A1"]/*[[".cells.staticTexts[\"A1\"]",".staticTexts[\"A1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        starButton.tap()
        app.sheets["Remove from MyDiary"].buttons["Yes"].tap()
        app.navigationBars["TalesAndSpirits.RecipeSceneView"].buttons["My Diary"].tap()
    }

}
