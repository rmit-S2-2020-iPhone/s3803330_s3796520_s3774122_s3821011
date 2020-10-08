//
//  MyDiaryTableViewController.swift
//  TalesAndSpirits
//
//  Created by Prodip Guha Roy on 24/8/20.
//  Copyright © 2020 RMIT. All rights reserved.
//

import UIKit

class MyDiaryTableViewController: UITableViewController {
    
    var cocktailViewModel: CocktailViewModel = CocktailViewModel.shared
    
//    var favoriteCocktailsIndices: [Int] {
//        guard let cocktailViewModel = cocktailViewModel else{ return [] }
//        var indices: [Int] = []
//        var index = 0
//        while index < cocktailViewModel.count {
//            if cocktailViewModel.getCocktailIsFavorite(byIndex: index){
//                indices.append(index)
//            }
//            index += 1
//        }
//        return indices
//    }
    
    
//    var favoriteCocktails : [Cocktail] {
//        var favCocktails: [Cocktail] = []
//        var index = 0
//        guard let count = cocktailViewModel?.count else { return favCocktails}
//        while index < count {
//            guard let cocktail: Cocktail = cocktailViewModel?.getCocktail(byIndex: index) else{return favCocktails}
//            if cocktail.isFavorite{
//                favCocktails.append(cocktail)
//            }
//            index += 1
//        }
//        return favCocktails
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (cocktailViewModel.favoriteCocktailCount + 2)
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath)
            let myDiaryLabel = cell.viewWithTag(1000) as? UILabel
            
            if let myDiaryLabel = myDiaryLabel {
                myDiaryLabel.text = "My Diary"
            }
            
        }else if indexPath.row == 1{
            cell = tableView.dequeueReusableCell(withIdentifier: "AddButtonCell", for: indexPath)
    
        }else{
            cell = tableView.dequeueReusableCell(withIdentifier: "CocktailCell", for: indexPath)
            
            let imageView = cell.viewWithTag(1003) as? UIImageView
            
            let cocktailNameLabel = cell.viewWithTag(1004) as? UILabel
            
            if let imageView = imageView, let cocktailNameLabel = cocktailNameLabel{
                //fetch cocktail index for favorite cocktail
//                let index = favoriteCocktailsIndices[(indexPath.row - 2)]
//
//                imageView.image = cocktailViewModel.getCocktailImage(byIndex: index)
//                cocktailNameLabel.text = cocktailViewModel.getCocktailName(byIndex: index)
                cocktailNameLabel.text = cocktailViewModel.getFavoriteCocktailName(byIndex: indexPath.row - 2)
                imageView.image = cocktailViewModel.getFavoriteCocktailImage(byIndex: indexPath.row - 2)
                
                
                
//                let currentCocktail = favoriteCocktails[(indexPath.row - 2)]
//                let index = cocktailViewModel!.getCocktailIndex(newCocktail: currentCocktail)
//
//                let cocktailDetails: (cocktailName: String, image: UIImage?) = cocktailViewModel!.getCocktail(byIndex: index)
//
//                imageView.image = cocktailDetails.image
//                cocktailNameLabel.text = cocktailDetails.cocktailName
                
            }
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1{
            return 200
        }else{
            return UITableViewAutomaticDimension
        }
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        guard let selectedRow = self.tableView.indexPathForSelectedRow
            else {return}
        
        let newDestination = segue.destination as? RecipeSceneViewController
        
        if let newDestination = newDestination{
            newDestination.cocktailViewModel = cocktailViewModel
            //let index = favoriteCocktailsIndices[(selectedRow.row - 2)]
            //newDestination.index = index
            
        }
        
    }

}
