//
//  MyDiaryViewModel.swift
//  TalesAndSpirits
//
//  Created by Prodip Guha Roy on 24/8/20.
//  Copyright © 2020 RMIT. All rights reserved.
//

import Foundation
import UIKit

struct CocktailViewModel {
    
    //Reference to model
    private var cocktails: [Cocktail] = []
    //private var favCocktails: [FavouriteCocktail] = []
    private var model = REST_Request.shared
    
    var delegate: RefreshData?{
        get{ return model.delegate}
        set(value){
            model.delegate = value
        }
    }
    
    var count: Int{
        return model.cocktails.count
    }
    
    private mutating func loadData(){
        getCocktailDetailFromJSON()
        
        /*Hard coding Long Island Iced Tea to be a favorite cocktail which will be displayed in MyDiary TabBar
         *This hard coding will be removed in assignment.
        */
        for cocktail in cocktails {
            if cocktail.cocktailName == "Long Island Iced Tea"{
                cocktail.isFavorite = true
            }
        }
    }
    
    func getCocktailIndex(newCocktail: Cocktail) -> Int{
        var index = 0
        while index < model.cocktails.count {
            if newCocktail === model.cocktails[index]{
                return index
            }
            index += 1
        }
        return -1
    }
    
    init() {
        //loadData()
        model.fetchCocktails()
    }
    
    func getAllCocktails() -> [Cocktail]{
        return model.cocktails
    }
    
    func getCocktail(byIndex index: Int) -> Cocktail {
        
        return model.cocktails[index]
        
    }
    func getCocktail(byIndex index: Int) -> (cocktailName: String, image: UIImage?) {
        
        let cocktailName = model.cocktails[index].cocktailName
        let image = getCocktailImage(index: index)
        
        return (cocktailName, image)
        
    }
    
    func fetchCocktailById(index: Int){
        model.fetchCocktailById(index: index)
    }
    
    private func getCocktailImage(index: Int) -> UIImage?{
        let url = model.cocktails[index].imageName
        guard let imageURL = URL(string: url) else{ return nil}
        let data = try? Data(contentsOf: imageURL)
        var image: UIImage? = nil
        if let imageData = data{
            image = UIImage(data: imageData)
        }
        return image
    }
    
//    mutating func addCocktail(cocktailName: String, imageName: String){
//
//        self.cocktails.append(Cocktail(cocktailName: cocktailName, imageName: imageName))
//    }
    
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
    
    private func fetchCocktailDetails(byJson json: String) -> Cocktail {
        let jsonData = json.data(using: .utf8)
        
        let fetchDetails: CocktailsJson = try! JSONDecoder().decode(CocktailsJson.self, from: jsonData!)
        
        let cocktailDetails = fetchDetails.drinks[0]
        
        return convertCocktailJsonTOCocktail(cocktailJson: cocktailDetails)
        
    }
    
    private func convertCocktailJsonTOCocktail( cocktailJson: CocktailJson) -> Cocktail {
        
        let newCocktail = Cocktail(cocktailId: "",cocktailName: cocktailJson.strDrink, imageName: cocktailJson.strDrinkThumb)
        
        if let category = cocktailJson.strCategory, let glassType = cocktailJson.strGlass, let iBA = cocktailJson.strIBA, let instructions = cocktailJson.strInstructions {
        newCocktail.category =  category
        newCocktail.glassType =  glassType
        newCocktail.iBA =  iBA
        newCocktail.instructions =  instructions
        }
        
        //Populating ingredients
        var ingredientsList: [(name: String, quantity: String)] = []
        var ingredient: (name: String, quantity: String)

        if let ingredientName = cocktailJson.strIngredient1, let quantity = cocktailJson.strMeasure1 {
            ingredient.name = ingredientName
            ingredient.quantity = quantity
            ingredientsList.append(ingredient)
        }
        if let ingredientName = cocktailJson.strIngredient2, let quantity = cocktailJson.strMeasure2 {
            ingredient.name = ingredientName
            ingredient.quantity = quantity
            ingredientsList.append(ingredient)
        }
        if let ingredientName = cocktailJson.strIngredient3, let quantity = cocktailJson.strMeasure3 {
            ingredient.name = ingredientName
            ingredient.quantity = quantity
            ingredientsList.append(ingredient)
        }
        if let ingredientName = cocktailJson.strIngredient4, let quantity = cocktailJson.strMeasure4 {
            ingredient.name = ingredientName
            ingredient.quantity = quantity
            ingredientsList.append(ingredient)
        }
        if let ingredientName = cocktailJson.strIngredient5, let quantity = cocktailJson.strMeasure5 {
            ingredient.name = ingredientName
            ingredient.quantity = quantity
            ingredientsList.append(ingredient)
        }
        if let ingredientName = cocktailJson.strIngredient6, let quantity = cocktailJson.strMeasure6 {
            ingredient.name = ingredientName
            ingredient.quantity = quantity
            ingredientsList.append(ingredient)
        }
        if let ingredientName = cocktailJson.strIngredient7, let quantity = cocktailJson.strMeasure7 {
            ingredient.name = ingredientName
            ingredient.quantity = quantity
            ingredientsList.append(ingredient)
        }
        
        if let ingredientName = cocktailJson.strIngredient8, let quantity = cocktailJson.strMeasure8 {
            ingredient.name = ingredientName
            ingredient.quantity = quantity
            ingredientsList.append(ingredient)
        }
        if let ingredientName = cocktailJson.strIngredient9, let quantity = cocktailJson.strMeasure9 {
            ingredient.name = ingredientName
            ingredient.quantity = quantity
            ingredientsList.append(ingredient)
        }
        if let ingredientName = cocktailJson.strIngredient10, let quantity = cocktailJson.strMeasure10 {
            ingredient.name = ingredientName
            ingredient.quantity = quantity
            ingredientsList.append(ingredient)
        }
        
        newCocktail.ingredients = ingredientsList
        
        return newCocktail
    }
    
}
