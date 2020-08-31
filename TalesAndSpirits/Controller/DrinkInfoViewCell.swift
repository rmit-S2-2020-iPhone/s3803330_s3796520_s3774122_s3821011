//
//  DrinkInfoViewCell.swift
//  TalesAndSpirits
//
//  Created by Henry Chin on 31/8/20.
//  Copyright © 2020 RMIT. All rights reserved.
//

import UIKit

class DrinkInfoViewCell: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let recipeSceneModel = RecipeSceneViewModel()
    
    @IBOutlet weak var drinkInfoView: UITableView!
    @IBOutlet weak var drinkInfoCell: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drinkInfoView.dataSource = self
        drinkInfoView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeSceneModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CKCell", for: indexPath)
        
        let imageView = cell.viewWithTag(1000) as? UIImageView
        
        let cocktailNameLabel = cell.viewWithTag(1001) as? UILabel
        
        if let imageView = imageView, let cocktailNameLabel = cocktailNameLabel {
            
            //imageView.image = UIImage(named: "liit")
            //cocktailNameLabel.text = "Long Island Ice Tea"
            let currentCocktail = recipeSceneModel.getCocktail(byIndex: indexPath.row)
            
            imageView.image = currentCocktail.image
            cocktailNameLabel.text = currentCocktail.cocktailName
            
        }
        
        return cell
}

}
