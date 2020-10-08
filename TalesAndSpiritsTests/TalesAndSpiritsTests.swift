//
//  TalesAndSpiritsTests.swift
//  TalesAndSpiritsTests
//
//  Created by PUJA on 14/8/20.
//  Copyright © 2020 RMIT. All rights reserved.
//

import XCTest
@testable import TalesAndSpirits

class TalesAndSpiritsTests: XCTestCase {
    
    var restRequest: REST_Request!
    var manhattan : Cocktail!
    var sampleDrink : CocktailJson!
    var oldFashioned : FavouriteCocktail!

    override func setUp() {
        super.setUp()
        
        manhattan = Cocktail(cocktailId: "1001", cocktailName: "Manhattan", imageName: "1001.jpg")
        
        sampleDrink = CocktailJson(idDrink: "1002", strDrink: "Strong", strDrinkThumb: "1002.jpg", strCategory: "str", strIBA: nil, strGlass: "Old-fashioned glass", strInstructions: "Pour drink into cup", strIngredient1: "Sugar", strIngredient2: "Ice cubes", strIngredient3: "Whisky", strIngredient4: "Gin", strIngredient5: "Water", strIngredient6: nil, strIngredient7: nil, strIngredient8: nil, strIngredient9: nil, strIngredient10: nil, strMeasure1: "1 oz", strMeasure2: "1 oz", strMeasure3: nil, strMeasure4: nil, strMeasure5: nil, strMeasure6: nil, strMeasure7: nil, strMeasure8: nil, strMeasure9: nil, strMeasure10: nil)
        
        oldFashioned = FavouriteCocktail(cocktailName: "oldFashioned", imageName: "1003.jpg", isUserDefined: false, personalizedNote: "notes")
        
        // Put setup code here. This method is called before the invocation of each test method in the class.`
    }

    override func tearDown() {
        super.tearDown()
        
        manhattan = nil
        sampleDrink = nil
        oldFashioned = nil
        
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test() {
        
    }

    func testCocktail() {
        
        //manhattan.isFavorite = true
            
        XCTAssertEqual(manhattan.cocktailId, "1001")
        XCTAssertFalse(manhattan.cocktailName == "Manhatan")
        XCTAssertTrue((manhattan.imageName).contains(".jpg"))
        XCTAssertFalse(manhattan.isFavorite, "It should not be a favourite by default")
        XCTAssertFalse(manhattan.isUserDefined, "It should not be a user defined drink")
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testCocktailJSON() {
        
        XCTAssertTrue(sampleDrink.strIBA == nil)
        XCTAssertTrue(sampleDrink.strIngredient1 != nil)
        XCTAssertTrue((sampleDrink.idDrink).contains("1002"))
        XCTAssertFalse((sampleDrink.strInstructions)!.isEmpty)
        XCTAssertEqual(sampleDrink.strMeasure2, "1 oz")
    }
    
    func testFavouriteCocktail() {
        
        oldFashioned.isFavorite = true

        XCTAssertTrue(oldFashioned.isFavorite, "False by default but now true")
        XCTAssertFalse(oldFashioned.isUserDefined, "It should be false by default")
        XCTAssertTrue((oldFashioned.iBA).isEmpty)
        XCTAssertTrue((oldFashioned.cocktailId).isEmpty)
        XCTAssertFalse((oldFashioned.cocktailName).isEmpty)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testBaseURL() {
        //REST_Request.fetchCocktails(url)
        
        //let url = "https://www.thecocktaildb.com/api/json/v1/1/"
        //let test = REST_Request.init()
        //var test1 = restRequest.cocktails
        //test1.append(manhattan)
        //test.fetchCocktails()
        //test.fetchCocktailById(index: 3)
        
        //var apitest = restRequest.fetchCocktails()
        //restRequest.cocktails.append(manhattan)
        //let foo = apitest.parse(json)
        //let responseCode = expectation(description: "Status code: 200")
        //restRequest.cocktails
        //XCTAssertEqual(apitest.self, url)
        //XCTAssertEqual(HTTPURLResponse.statuscode, responseCode)
    }
    
    func testCocktailID() {
        
        //XCTAssertEqual(cocktail.cocktailId)
    }

}
