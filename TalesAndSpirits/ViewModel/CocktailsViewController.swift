//
//  CocktailsViewController.swift
//  TalesAndSpirits
//
//  Created by Prodip Guha Roy on 23/8/20.
//  Copyright © 2020 RMIT. All rights reserved.
//

import UIKit

class CocktailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var cocktailsTableView: UITableView!
    @IBOutlet weak var cocktailNameLabel: UILabel!
    @IBOutlet weak var cocktailImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cocktailsTableView.dataSource = self
        cocktailsTableView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    private var cocktails: [Cocktail] = []
    private var favCocktails: [FavouriteCocktail] = []
    
    func getCocktail(byIndex index: Int) -> (cocktailName: String, image: UIImage?) {
        
        let cocktailName = cocktails[index].cocktailName
        let image = UIImage(named: cocktails[index].imageName)
        
        return (cocktailName, image)
        
    }
    
    func getCocktail(byIndex index: Int) -> Cocktail {
        
        return cocktails[index]
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CKCell", for: indexPath)
        
        let imageView = cell.viewWithTag(1000) as? UIImageView
        
        let cocktailNameLabel = cell.viewWithTag(1001) as? UILabel
        
        if let imageView = imageView, let cocktailNameLabel = cocktailNameLabel {
            
//            imageView.image = UIImage(named: "liit")
//            cocktailNameLabel.text = "Long Island Ice Tea"
            let currentCocktail: (cocktailName: String, image: UIImage?) = CocktailsViewController.getCocktail(byIndex: indexPath.row)
            imageView.image = currentCocktail.image
            cocktailNameLabel.text = currentCocktail.cocktailName
            
        }
        
        return cell
    }
    
}
