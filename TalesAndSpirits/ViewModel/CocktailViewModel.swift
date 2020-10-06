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
    //private var cocktails: [Cocktail] = []
    //private var favCocktails: [FavouriteCocktail] = []
    private var model = REST_Request.shared
    private var favoriteCocktailModel = CocktailDBManager.shared
    
    private let randomizeImageName: String = "random-dice"
    private let randomizeText: String = "Surprise Me"
    
    var delegate: RefreshData?{
        get{ return model.delegate}
        set(value){
            model.delegate = value
        }
    }
    
    var count: Int{
        return model.cocktails.count
    }
    
    var favoriteCocktailCount: Int{
        return favoriteCocktailModel.cocktails.count
    }
    
    func setCocktailAsFavorite(index: Int){
        favoriteCocktailModel.addCocktail(model.cocktails[index])
    }
    
    func removeCocktailFromFavorite(index: Int){
        favoriteCocktailModel.deleteCocktail(index: 3)
    }
    
    func getFavoriteCocktailImage(byIndex index: Int) -> UIImage?{
        return UIImage(data: favoriteCocktailModel.cocktails[index].image! as Data)
    }
    
    func getFavoriteCocktailName(byIndex index: Int) -> String{
        return favoriteCocktailModel.cocktails[index].name!
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
        model.fetchCocktails()
    }
    
    
    func getRandomizeImage() -> UIImage?{
        return UIImage(named: randomizeImageName)
    }
    
    func getRandomizeText() -> String{
        return randomizeText
    }
    
    func fetchCocktailById(index: Int){
        model.fetchCocktailById(index: index)
    }
    
    func fetchRandomCocktail(){
        model.fetchRandomCocktail()
    }
    
    func getCocktailName(byIndex index: Int) -> String{
        return model.cocktails[index].cocktailName
    }
    
    func getCocktailImage(byIndex index: Int) -> UIImage?{
        //Check if model contains image, else fetch image from network
        guard let image = model.cocktails[index].image else {
            let url = model.cocktails[index].imageName
            guard let imageURL = URL(string: url) else{ return nil}
            let data = try? Data(contentsOf: imageURL)
            var image: UIImage? = nil
            if let imageData = data{
                image = UIImage(data: imageData)
            }
            model.cocktails[index].image = image
            return image
        }
        return image
    }
    
    func getCocktailCategory(byIndex index: Int) -> String{
        return model.cocktails[index].category
    }
    
    func getCocktailiBA(byIndex index: Int) -> String{
        return model.cocktails[index].iBA
    }
    
    func getCocktailInstructions(byIndex index: Int) -> String{
        return model.cocktails[index].instructions
    }
    
    func getCocktailGlassType(byIndex index: Int) -> String{
        return model.cocktails[index].glassType
    }
    
    func getCocktailPersonalizedNote(byIndex index: Int) -> String{
        return model.cocktails[index].personalizedNote
    }
    
    func getCocktailIngredients(byIndex index: Int) -> [(name: String, quantity: String)]{
        return model.cocktails[index].ingredients
    }
    
    func getCocktailIsFavorite(byIndex index: Int) ->Bool{
        return model.cocktails[index].isFavorite
    }
    
    func getCocktailIsUserDefined(byIndex index: Int) ->Bool{
        return model.cocktails[index].isUserDefined
    }
    
    func setCocktailAsFavorite(byIndex index: Int, value: Bool){
        model.cocktails[index].isFavorite = value
    }
    
    func setCocktailPersonalNote(byIndex index: Int, note: String){
        model.cocktails[index].personalizedNote = note
    }
    
}
