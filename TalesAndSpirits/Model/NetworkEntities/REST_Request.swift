//
//  REST_Request.swift
//  TalesAndSpirits
//
//  Created by Prodip Guha Roy on 25/9/20.
//  Copyright © 2020 RMIT. All rights reserved.
//

import Foundation
import UIKit

protocol RefreshData {
    func updateUIWithRestData(_ index: Int?)
}

class REST_Request{
    
    private var _cocktails:[Cocktail]
    var delegate: RefreshData?
    
    private let session = URLSession.shared
    private let baseUrl:String = "https://www.thecocktaildb.com/api/json/v1/1/"
    private let listCocktails:String = "filter.php?c=Cocktail"
    private let lookupCocktailById: String = "lookup.php?i="
    private let search:String = "search.php?s="
    private let randomize:String = "random.php"
    
    var cocktails:[Cocktail]{
        return _cocktails
    }
    
    private init(){
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
        if let url = URL(string: url){
            let request = URLRequest(url: url)
            getCocktailById(request, index: index)
        }
        
    }
    
    func fetchRandomCocktail(){
        let url = baseUrl + randomize
        if let url = URL(string: url){
            let request = URLRequest(url: url)
            getRandomCocktail(request)
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
                //Notify Controller Cocktail Data is retrieved
                DispatchQueue.main.sync {
                    self.delegate?.updateUIWithRestData(nil)
                }
                
                for cocktail in self.cocktails{
                    if cocktail.image == nil{
                        self.getCocktailImage(cocktail: cocktail)
                    }
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
                    self.fetchDetailsFromJson(cocktailJson: cocktailDetails, index: index)
                }
                
                DispatchQueue.main.sync {
                    self.delegate?.updateUIWithRestData(nil)
                }
            }
        })
        task.resume()
    }
    
    private func getCocktailImage(cocktail : Cocktail){
        let url = cocktail.imageName
        guard let imageURL = URL(string: url) else{ return }
        let data = try? Data(contentsOf: imageURL)
        var image: UIImage? = nil
        if let imageData = data{
            image = UIImage(data: imageData)
        }
        cocktail.image = image
    }
    
    private func getRandomCocktail(_ request: URLRequest){
        let task = session.dataTask(with: request, completionHandler: {
            data, response, fetchError in
            if let error = fetchError{
                print(error)
            }else{
                var index = self._cocktails.count //setting default index as last of the array
                let fetchDetails: CocktailsJson = try! JSONDecoder().decode(CocktailsJson.self, from: data!)
                if fetchDetails.drinks.count > 0{
                    let cocktailDetails = fetchDetails.drinks[0]
                    //checking if cocktail already exists
                    let getCocktailIndex = self.checkIfCocktailExists(drinkId: cocktailDetails.idDrink)
                    if( getCocktailIndex != -1){
                        index = getCocktailIndex
                    }
                    self.fetchDetailsFromJson(cocktailJson: cocktailDetails, index: index)
                }
                
                DispatchQueue.main.sync {
                    self.delegate?.updateUIWithRestData(index)
                }
            }
        })
        task.resume()
    }
    
    /**
     * This function checks the _cocktails list to find if a object exists with id = drinkid
     * if found, return index of cocktail object
     * else return -1
     */
    private func checkIfCocktailExists( drinkId: String) -> Int{
        for (index, cocktail) in _cocktails.enumerated(){
            if cocktail.cocktailId == drinkId{
                return index
            }
        }
        return -1
    }
    
    private func fetchDetailsFromJson(cocktailJson: CocktailJson, index: Int) {
        
        //If index equal count of cocktails, adding new cocktail
        if index == _cocktails.count{
            let newCocktail = Cocktail(cocktailId: cocktailJson.idDrink, cocktailName: cocktailJson.strDrink, imageName: cocktailJson.strDrinkThumb)
            self._cocktails.append(newCocktail)
            
        }
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
