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
    
    func addUserDefinedCocktail(_ cocktailDetails: [String: String], image: UIImage?){
        
        if let name = cocktailDetails["name"]{
        let newCocktail = Cocktail(cocktailId: Cocktail.nextUserDefinedId, cocktailName: name, imageName: "")
            
            newCocktail.isUserDefined = true
            newCocktail.isFavorite = true
            //Fill rest values for cocktail
//            newCocktail.category = category
//            newCocktail.iBA = iBA
//            newCocktail.glassType = glass
//            newCocktail.
//            newCocktail.image = image
            
            favoriteCocktailModel.addCocktail(newCocktail)
        }
        
        
    }
}
