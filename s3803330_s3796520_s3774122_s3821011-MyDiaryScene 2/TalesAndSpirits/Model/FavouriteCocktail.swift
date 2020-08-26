//
//  FavouriteCocktail.swift
//  TalesAndSpirits
//
//  Created by Prodip Guha Roy on 24/8/20.
//  Copyright © 2020 RMIT. All rights reserved.
//

import Foundation
class FavouriteCocktail: Cocktail {
    private var review: String
    private var personalizedNote: String
    
    init(cocktailName: String, imageName: String, review: String, personalizedNote: String) {
        self.review = review
        self.personalizedNote = personalizedNote
        super.init(cocktailName: cocktailName, imageName: imageName)
    }
}

