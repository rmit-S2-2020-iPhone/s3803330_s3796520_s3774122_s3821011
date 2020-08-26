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
    
    var count: Int{
        return cocktails.count
    }
    
    private mutating func loadData(){
        cocktails.append(Cocktail(cocktailName: "Manhattan", imageName: "manhattan"))
        cocktails.append(Cocktail(cocktailName: "LITT", imageName: "liit"))
        cocktails.append(Cocktail(cocktailName: "Margarita", imageName: "margarita"))
        cocktails.append(Cocktail(cocktailName: "Old Fashioned", imageName: "oldfashioned"))
        cocktails.append(Cocktail(cocktailName: "Mojito", imageName: "mojito"))
    }
    
    init() {
        loadData()
    }
    
    func getCocktail(byIndex index: Int) -> (cocktailName: String, image: UIImage?) {
        let cocktailName = cocktails[index].cocktailName
        let image = UIImage(named: cocktails[index].imageName)
        return (cocktailName, image)
    }
}
