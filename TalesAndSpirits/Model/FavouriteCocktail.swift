//
//  FavouriteCocktail.swift
//  TalesAndSpirits
//
//  Created by Prodip Guha Roy on 24/8/20.
//  Copyright © 2020 RMIT. All rights reserved.
//

import Foundation
class FavouriteCocktail: Cocktail {
    private var _isUserDefined: Bool
    private var _personalizedNote: String
    
//    var isUserDefined: Bool {
//        get { return _isUserDefined }
//        set(newValue) {
//            _isUserDefined = newValue
//        }
//    }
//
//    var personalizedNote: String {
//        get { return _personalizedNote }
//        set(newNote) {
//            _personalizedNote = newNote
//        }
//    }
    
    init(cocktailName: String, imageName: String, isUserDefined: Bool, personalizedNote: String) {
        self._isUserDefined = isUserDefined
        self._personalizedNote = personalizedNote
        super.init(cocktailName: cocktailName, imageName: imageName)
    }
}

