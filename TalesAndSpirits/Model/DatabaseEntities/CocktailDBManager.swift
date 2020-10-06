//
//  CocktailDBManager.swift
//  TalesAndSpirits
//
//  Created by Prodip Guha Roy on 6/10/20.
//  Copyright © 2020 RMIT. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CocktailDBManager{
    
    static let shared = CocktailDBManager()
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let managedContext: NSManagedObjectContext
    
    private (set) var cocktails: [CocktailEntity]
    
    func addCocktail( _ cocktail: Cocktail){
        
        let nsCocktail = createNSCocktail(cocktail)
        //print(nsCocktail.image!)
        cocktails.append(nsCocktail)
        
        do {
            try managedContext.save()
            print("saved to DB")
        }catch let error as NSError{
            print("Unable to save data to core data:  \(error), \(error.userInfo)")
        }
        
    }
    
    func deleteCocktail(index: Int){
        
        let cocktailToRemove = cocktails.remove(at: index)
        //Delete data from context
        managedContext.delete(cocktailToRemove)
        
        // save the context to remove the data
        do{
            try managedContext.save()
        }catch let error as NSError{
            print("Unable to remove data from core data:  \(error), \(error.userInfo)")
        }
        
    }
    
    private func loadCocktails(){
        do{
            //let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CocktailEntity")
            
            //let result = try managedContext.fetch(fetchRequest)
            let result = try managedContext.fetch(CocktailEntity.fetchRequest())
            cocktails = result as! [CocktailEntity]
            print("loadData")
            for cocktail in cocktails{
                print(cocktail)
            }
        }catch let error as NSError{
            print("Unable to load data from core data: \(error), \(error.userInfo)")
        }
    }
    
    
    
    private func createNSIngredient(_ name: String, _ quantity: String) -> Ingredient{
        
        let ingredientEntity = NSEntityDescription.entity(forEntityName: "Ingredient", in: managedContext)!
        
        let nsIngredient = NSManagedObject(entity: ingredientEntity, insertInto: managedContext) as! Ingredient
        
        nsIngredient.setValue(name, forKeyPath: "name")
        nsIngredient.setValue(quantity, forKeyPath: "quantity")
        
        return nsIngredient
    }
    
    private func createNSCocktail(_ cocktail: Cocktail) -> CocktailEntity{
        let cocktailEntity = NSEntityDescription.entity(forEntityName: "CocktailEntity", in: managedContext)!
        
        let nsCocktail = NSManagedObject(entity: cocktailEntity, insertInto: managedContext) as! CocktailEntity
        
        nsCocktail.setValue(cocktail.cocktailId, forKeyPath: "id")
        nsCocktail.setValue(cocktail.cocktailName, forKeyPath: "name")
        nsCocktail.setValue(cocktail.category, forKeyPath: "category")
        nsCocktail.setValue(cocktail.iBA, forKeyPath: "iba")
        nsCocktail.setValue(cocktail.instructions, forKeyPath: "instructions")
        nsCocktail.setValue(cocktail.glassType, forKeyPath: "glassType")
        nsCocktail.setValue(cocktail.personalizedNote, forKeyPath: "personalizedNote")
        nsCocktail.setValue(cocktail.isUserDefined, forKeyPath: "isUserDefined")
        
        if let image = cocktail.image{
            let imageData = UIImageJPEGRepresentation(image, 0.8) as NSData?
            nsCocktail.image = imageData
        }
        
        for ingredient in cocktail.ingredients{
            let nsIngredient = createNSIngredient(ingredient.name, ingredient.quantity)
            nsCocktail.addToIngredients(nsIngredient)
        }
        
        return nsCocktail
        
    }
    
    private init(){
        managedContext = appDelegate.persistentContainer.viewContext
        cocktails = []
        loadCocktails()
    }
    
    
    
}
