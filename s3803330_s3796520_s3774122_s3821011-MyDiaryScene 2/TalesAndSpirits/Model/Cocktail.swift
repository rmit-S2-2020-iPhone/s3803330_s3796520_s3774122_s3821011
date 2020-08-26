//
//  SampleCocktail.swift
//  TalesAndSpirits
//
//  Created by Prodip Guha Roy on 24/8/20.
//  Copyright © 2020 RMIT. All rights reserved.
//

import Foundation

class Cocktail {
    
    private var _cocktailName: String
    private var _imageName: String
    private var _ingredients: Dictionary<String, String>
    private var _category: String
    private var _iBA: String
    private var _instructions: String
    private var _glassType: String
    
    var cocktailName: String {
        get { return _cocktailName }
        set(newName) {
            _cocktailName = newName
        }
    }
    
    var imageName: String {
        get { return _imageName }
        set(newImageName) {
            _imageName = newImageName
        }
    }
    
    init(cocktailName: String, imageName: String) {
        self._cocktailName = cocktailName
        self._imageName = imageName
        self._ingredients = Dictionary<String, String>()
        self._category = ""
        self._iBA = ""
        self._glassType = ""
        self._instructions = ""
    }
    class func createArray() -> [Cocktail]{
        var cocktails: [Cocktail] = []
        let cocktail1 = Cocktail(cocktailName: "LIIT", imageName: "cocktail1")
        let cocktail2 = Cocktail(cocktailName: "MOJITO", imageName: "cocktail2")
        let cocktail3 = Cocktail(cocktailName: "MARGARITA", imageName: "cocktail3")
        let cocktail4 = Cocktail(cocktailName: "COSMOPOLITAN", imageName: "cocktail4")
        let cocktail5 = Cocktail(cocktailName: "LIIT", imageName: "cocktail1")
        let cocktail6 = Cocktail(cocktailName: "MOJITO", imageName: "cocktail2")
        let cocktail7 = Cocktail(cocktailName: "MARGARITA", imageName: "cocktail3")
        let cocktail8 = Cocktail(cocktailName: "COSMOPOLITAN", imageName: "cocktail4")
        let cocktail9 = Cocktail(cocktailName: "LIIT", imageName: "cocktail1")
        let cocktail10 = Cocktail(cocktailName: "MOJITO", imageName: "cocktail2")
        let cocktail11 = Cocktail(cocktailName: "MARGARITA", imageName: "cocktail3")
        let cocktail12 = Cocktail(cocktailName: "COSMOPOLITAN", imageName: "cocktail4")
        cocktails.append(cocktail1)
        cocktails.append(cocktail2)
        cocktails.append(cocktail3)
        cocktails.append(cocktail4)
        cocktails.append(cocktail5)
        cocktails.append(cocktail6)
        cocktails.append(cocktail7)
        cocktails.append(cocktail8)
        cocktails.append(cocktail9)
        cocktails.append(cocktail10)
        cocktails.append(cocktail11)
        cocktails.append(cocktail12)
        
        return cocktails
    }
    
}


