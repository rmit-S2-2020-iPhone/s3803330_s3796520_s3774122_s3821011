//
//  CocktailsViewController.swift
//  TalesAndSpirits
//
//  Created by Prodip Guha Roy on 23/8/20.
//  Copyright © 2020 RMIT. All rights reserved.
//

import UIKit

class CocktailsViewController: UITableViewController, RefreshData {
    
    var cocktailViewModel: CocktailViewModel?
    
    
    @IBOutlet var cocktailsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        cocktailViewModel?.delegate = self

    }
    
    func updateUIWithRestData() {
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
            
            if let imageView = imageView, let cocktailNameLabel = cocktailNameLabel, let cocktailViewModel = cocktailViewModel {
                imageView.image = cocktailViewModel.getCocktailImage(byIndex: indexPath.row - 1)
                cocktailNameLabel.text = cocktailViewModel.getCocktailName(byIndex: indexPath.row - 1)
                
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
            cocktailViewModel?.fetchCocktailById(index: selectedRow.row-1)
            newDestination.cocktailViewModel = cocktailViewModel
            newDestination.index = selectedRow.row-1
        }
    }
    
}
