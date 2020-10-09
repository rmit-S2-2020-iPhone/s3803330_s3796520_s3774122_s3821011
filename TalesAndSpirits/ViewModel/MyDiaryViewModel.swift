//
//  MyDiaryViewModel.swift
//  TalesAndSpirits
//
//  Created by Prodip Guha Roy on 9/10/20.
//  Copyright © 2020 RMIT. All rights reserved.
//

import Foundation
import UIKit

class MyDiaryViewModel: CocktailViewModel{
    
    override init() {
        super.init()
        super.copySavedCocktailsFromDBToModel()
    }
    
    override var count: Int{
        return favoriteCocktailModel.cocktails.count
    }
    
    override func getCocktailImage(byIndex index: Int) -> UIImage?{
        return UIImage(data: favoriteCocktailModel.cocktails[index].image! as Data)
    }
    
    override func getCocktailName(byIndex index: Int) -> String{
        return favoriteCocktailModel.cocktails[index].name!
    }
    
    override func getCocktail(byIndex index: Int) -> Cocktail{
        return favoriteCocktailModel.convertCocktailEntityToCocktail(byIndex: index)
    }
}
