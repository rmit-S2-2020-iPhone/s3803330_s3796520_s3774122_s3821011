//
//  CocktailsViewController.swift
//  TalesAndSpirits
//
//  Created by Prodip Guha Roy on 23/8/20.
//  Copyright © 2020 RMIT. All rights reserved.
//

import UIKit

class CocktailsViewController: UITableViewController {
    
    
    
    private let diaryModelView = MyDiaryViewModel()
    
    @IBOutlet var cocktailsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diaryModelView.count+1
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
                let currentCocktail: (cocktailName: String, image: UIImage?) = diaryModelView.getCocktail(byIndex: indexPath.row-1)
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
            newDestination.displayCocktail = diaryModelView.getCocktail(byIndex: (selectedRow.row - 1))
        }
    }
    
}
