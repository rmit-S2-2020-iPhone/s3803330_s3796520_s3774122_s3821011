//
//  CocktailsViewController.swift
//  TalesAndSpirits
//
//  Created by Prodip Guha Roy on 23/8/20.
//  Copyright © 2020 RMIT. All rights reserved.
//

import UIKit

class CocktailsViewController: UITableViewController, RefreshData {
    
    
    
    
    //private let diaryModelView = CocktailViewModel()
    var cocktailViewModel: CocktailViewModel?
    
//    var cocktails : [Cocktail] {
//        return cocktailViewModel?.getAllCocktails() ?? []
//    }
    
    
    
    @IBOutlet var cocktailsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        cocktailViewModel?.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    func updateUIWithRestData() {
        //cocktails = cocktailViewModel?.getAllCocktails()
        self.tableView.reloadData()
    }

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cocktailViewModel!.count+1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell
        
        if indexPath.row != 0{
            cell = tableView.dequeueReusableCell(withIdentifier: "CocktailCell", for: indexPath)
            
            let imageView = cell.viewWithTag(1000) as? UIImageView
            
            let cocktailNameLabel = cell.viewWithTag(1001) as? UILabel
            
            if let imageView = imageView, let cocktailNameLabel = cocktailNameLabel {
                
                
                //            imageView.image = UIImage(named: "liit")
                //            cocktailNameLabel.text = "Long Island Ice Tea"
                let currentCocktail: (cocktailName: String, image: UIImage?) = cocktailViewModel!.getCocktail(byIndex: indexPath.row-1)
                    //cocktails[indexPath.row-1]
                imageView.image = currentCocktail.image
                cocktailNameLabel.text = currentCocktail.cocktailName
                
            }
        }
        else{
        cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath)
            
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let selectedRow = self.tableView.indexPathForSelectedRow
            else {return}
        
        let newDestination = segue.destination as? RecipeSceneViewController
        
        if let newDestination = newDestination{
            newDestination.cocktailViewModel = cocktailViewModel
            newDestination.index = selectedRow.row-1
            //newDestination.displayCocktail = cocktailViewModel!.getCocktail(byIndex: selectedRow.row-1)
                //cocktails[(selectedRow.row - 1)]
        }
    }
    
}
