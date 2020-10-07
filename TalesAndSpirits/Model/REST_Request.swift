//
//  REST_Request.swift
//  TalesAndSpirits
//
//  Created by Prodip Guha Roy on 25/9/20.
//  Copyright © 2020 RMIT. All rights reserved.
//

import Foundation

protocol RefreshData {
    func updateUIWithRestData()
}

class REST_Request{
    
    private var _cocktails:[Cocktail]
    var delegate: RefreshData?
    
    private let session = URLSession.shared
    let baseUrl:String = "https://www.thecocktaildb.com/api/json/v1/1/"
    private let listCocktails:String = "filter.php?c=Cocktail"
    private let lookupCocktailById: String = "lookup.php?i="
    private let search:String = "search.php?s="
    
    var cocktails:[Cocktail]{
        return _cocktails
    }
    
    init(){
        _cocktails = []
    }
    
    static let shared = REST_Request()
    
    func fetchCocktails(){
        let url = baseUrl + listCocktails
        
        if let url = URL(string: url){
            let request = URLRequest(url: url)
            getCocktailList(request)
        }
    }
    
    func fetchCocktailById(index: Int){
        let id = _cocktails[index].cocktailId
        
        let url = baseUrl + lookupCocktailById + id
        print("url: \(url)")
        if let url = URL(string: url){
            let request = URLRequest(url: url)
            getCocktailById(request, index: index)
        }
        
    }
    
    private func getCocktailList(_ request: URLRequest){
        let task = session.dataTask(with: request, completionHandler: {
            data, response, fetchError in
            if let error = fetchError{
                print(error)
            }else{
                let fetchDetails: CocktailsJson = try! JSONDecoder().decode(CocktailsJson.self, from: data!)
                let allCocktails = fetchDetails.drinks
                
                for cocktail in allCocktails{
                    let newCocktail = Cocktail(cocktailId: cocktail.idDrink, cocktailName: cocktail.strDrink, imageName: cocktail.strDrinkThumb)
                    self._cocktails.append(newCocktail)
                }
                
                DispatchQueue.main.sync {
                    self.delegate?.updateUIWithRestData()
                }
            }
        })
        task.resume()
    }
    
    private func getCocktailById(_ request: URLRequest, index: Int){
        let task = session.dataTask(with: request, completionHandler: {
            data, response, fetchError in
            if let error = fetchError{
                print(error)
            }else{
                let fetchDetails: CocktailsJson = try! JSONDecoder().decode(CocktailsJson.self, from: data!)
                if fetchDetails.drinks.count > 0{
                    let cocktailDetails = fetchDetails.drinks[0]
                    print(cocktailDetails)
                    self.fetchDetailsFromJson(cocktailJson: cocktailDetails, index: index)
                }
                
                DispatchQueue.main.sync {
                    self.delegate?.updateUIWithRestData()
                }
            }
        })
        task.resume()
    }
    
    private func fetchDetailsFromJson(cocktailJson: CocktailJson, index: Int) {
        
        //let newCocktail = Cocktail(cocktailId: "",cocktailName: cocktailJson.strDrink, imageName: cocktailJson.strDrinkThumb)
        let cocktail = self._cocktails[index]
        
        if let category = cocktailJson.strCategory{
            cocktail.category =  category
        }
        if let glassType = cocktailJson.strGlass{
            cocktail.glassType =  glassType
        }
        if let iBA = cocktailJson.strIBA{
            cocktail.iBA =  iBA
            
        }
        if let instructions = cocktailJson.strInstructions {
            cocktail.instructions =  instructions
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
        
        cocktail.ingredients = ingredientsList
    }
    
}
