//
//  MyDiaryTableViewController.swift
//  TalesAndSpirits
//
//  Created by Prodip Guha Roy on 24/8/20.
//  Copyright © 2020 RMIT. All rights reserved.
//

import UIKit

class MyDiaryTableViewController: UITableViewController {

    //private let diaryModelView = CocktailViewModel()
    var cocktailViewModel: CocktailViewModel?
    
    var favoriteCocktails : [Cocktail] {
        var favCocktails: [Cocktail] = []
        var index = 0
        guard let count = cocktailViewModel?.count else { return favCocktails}
        while index < count {
            guard let cocktail: Cocktail = cocktailViewModel?.getCocktail(byIndex: index) else{return favCocktails}
            if cocktail.isFavorite{
                favCocktails.append(cocktail)
            }
            index += 1
        }
        return favCocktails
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationItem.titleView = UIImageView(image: UIImage(named: "logo"))
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        //tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (favoriteCocktails.count + 2)
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
            
            if let imageView = imageView, let cocktailNameLabel = cocktailNameLabel {
                
                //imageView.image = UIImage(named: "liit")
                //cocktailNameLabel.text = "Long Island Ice Tea"
                let currentCocktail = favoriteCocktails[(indexPath.row - 2)]
                let index = cocktailViewModel!.getCocktailIndex(newCocktail: currentCocktail)
                
                let cocktailDetails: (cocktailName: String, image: UIImage?) = cocktailViewModel!.getCocktail(byIndex: index)
                
                imageView.image = cocktailDetails.image
                cocktailNameLabel.text = cocktailDetails.cocktailName
                
            }
        }
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1{
            return 200
        }else{
            return UITableViewAutomaticDimension
        }
        
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        guard let selectedRow = self.tableView.indexPathForSelectedRow
            else {return}
        
        let newDestination = segue.destination as? RecipeSceneViewController
        
        if let newDestination = newDestination{
            newDestination.cocktailViewModel = cocktailViewModel
            let index = cocktailViewModel!.getCocktailIndex(newCocktail: favoriteCocktails[(selectedRow.row - 2)])
            newDestination.index = index
            //newDestination.displayCocktail = favoriteCocktails[(selectedRow.row - 2)]
            
        }
        
    }

}
