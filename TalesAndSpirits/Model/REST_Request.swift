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
    private let base_url:String = "https://www.thecocktaildb.com/api/json/v1/1/"
    private let list_cocktails:String = "filter.php?c=Cocktail"
    
    var cocktails:[Cocktail]{
        return _cocktails
    }
    
    private init(){
        _cocktails = []
    }
    
    static let shared = REST_Request()
    
    func fetchCocktails(){
        let url = base_url + list_cocktails
        
        if let url = URL(string: url){
            let request = URLRequest(url: url)
            getCocktailList(request)
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
}
