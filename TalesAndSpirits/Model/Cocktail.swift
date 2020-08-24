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
    
}


