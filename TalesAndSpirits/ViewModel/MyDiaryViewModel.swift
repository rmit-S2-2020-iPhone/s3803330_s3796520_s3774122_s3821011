//
//  MyDiaryViewModel.swift
//  TalesAndSpirits
//
//  Created by Prodip Guha Roy on 24/8/20.
//  Copyright © 2020 RMIT. All rights reserved.
//

import Foundation
import UIKit

struct MyDiaryViewModel {
    
    //Reference to model
    private var cocktails: [Cocktail] = []
    private var favCocktails: [FavouriteCocktail] = []
    
    var count: Int{
        return cocktails.count
    }
    
    private mutating func loadData(){
//        cocktails.append(Cocktail(cocktailName: "Manhattan", imageName: "manhattan"))
//        cocktails.append(Cocktail(cocktailName: "LITT", imageName: "liit"))
//        cocktails.append(Cocktail(cocktailName: "Margarita", imageName: "margarita"))
//        cocktails.append(Cocktail(cocktailName: "Old Fashioned", imageName: "oldfashioned"))
//        cocktails.append(Cocktail(cocktailName: "Mojito", imageName: "mojito"))
//        cocktails.append(Cocktail(cocktailName: "Manhattan", imageName: "manhattan"))
//        cocktails.append(Cocktail(cocktailName: "LITT", imageName: "liit"))
//        cocktails.append(Cocktail(cocktailName: "Margarita", imageName: "margarita"))
//        cocktails.append(Cocktail(cocktailName: "Old Fashioned", imageName: "oldfashioned"))
//        cocktails.append(Cocktail(cocktailName: "Mojito", imageName: "mojito"))
        getCocktailDetailFromJSON()
    }
    
    init() {
        loadData()
    }
    
    func getCocktail(byIndex index: Int) -> (cocktailName: String, image: UIImage?) {
        
        let cocktailName = cocktails[index].cocktailName
        let image = UIImage(named: cocktails[index].imageName)
        
        return (cocktailName, image)
        
    }
    
    mutating func addCocktail(cocktailName: String, imageName: String){
        
        self.cocktails.append(Cocktail(cocktailName: cocktailName, imageName: imageName))
    }
    
    private mutating func getCocktailDetailFromJSON(){
        let networkData = NetworkData();
        let jsonData = networkData.cocktailList.data(using: .utf8)
        
        let cocktails_id: CocktailsJson = try! JSONDecoder().decode(CocktailsJson.self, from: jsonData!)
        
        let idList = cocktails_id.drinks
        
        for id in idList {
            
            let json = networkData.detailedCocktail[id.idDrink]
            
            if let json = json {
                let cocktail = fetchCocktailDetails(byJson: json)
                cocktails.append(cocktail)
            }
            
        }
        
    }
    
    func fetchCocktailDetails(byJson json: String) -> Cocktail {
        let jsonData = json.data(using: .utf8)
        
        let fetchDetails: CocktailsJson = try! JSONDecoder().decode(CocktailsJson.self, from: jsonData!)
        
        let cocktailDetails = fetchDetails.drinks[0]
        
        return convertCocktailJsonTOCocktail(cocktailJson: cocktailDetails)
        
    }
    
    func convertCocktailJsonTOCocktail( cocktailJson: CocktailJson) -> Cocktail {
        
        let newCocktail = Cocktail(cocktailName: cocktailJson.strDrink, imageName: cocktailJson.strDrinkThumb)
        
        if let category = cocktailJson.strCategory, let glassType = cocktailJson.strGlass, let iBA = cocktailJson.strIBA, let instructions = cocktailJson.strInstructions {
        newCocktail.category =  category
        newCocktail.glassType =  glassType
        newCocktail.iBA =  iBA
        newCocktail.instructions =  instructions
        }
        
        //Populating ingredients
        var ingredientsList: [String: String] = [:]

        if let ingredientName = cocktailJson.strIngredient1, let quantity = cocktailJson.strMeasure1 {
            ingredientsList[ingredientName] = quantity
        }
        if let ingredientName = cocktailJson.strIngredient2, let quantity = cocktailJson.strMeasure2 {
            ingredientsList[ingredientName] = quantity
        }
        if let ingredientName = cocktailJson.strIngredient3, let quantity = cocktailJson.strMeasure3 {
            ingredientsList[ingredientName] = quantity
        }
        if let ingredientName = cocktailJson.strIngredient4, let quantity = cocktailJson.strMeasure4 {
            ingredientsList[ingredientName] = quantity
        }
        if let ingredientName = cocktailJson.strIngredient5, let quantity = cocktailJson.strMeasure5 {
            ingredientsList[ingredientName] = quantity
        }
        if let ingredientName = cocktailJson.strIngredient6, let quantity = cocktailJson.strMeasure6 {
            ingredientsList[ingredientName] = quantity
        }
        if let ingredientName = cocktailJson.strIngredient7, let quantity = cocktailJson.strMeasure7 {
            ingredientsList[ingredientName] = quantity
        }
        
        if let ingredientName = cocktailJson.strIngredient8, let quantity = cocktailJson.strMeasure8 {
            ingredientsList[ingredientName] = quantity
        }
        if let ingredientName = cocktailJson.strIngredient9, let quantity = cocktailJson.strMeasure9 {
            ingredientsList[ingredientName] = quantity
        }
        if let ingredientName = cocktailJson.strIngredient10, let quantity = cocktailJson.strMeasure10 {
            ingredientsList[ingredientName] = quantity
        }
        
        newCocktail.ingredients = ingredientsList
        
        return newCocktail
    }
    
}
