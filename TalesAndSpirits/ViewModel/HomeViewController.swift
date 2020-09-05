//
//  HomeViewController.swift
//  TalesAndSpirits
//
//  Created by Prodip Guha Roy on 23/8/20.
//  Copyright © 2020 RMIT. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    //private let diaryModelView = CocktailViewModel()
    var cocktailModelView: CocktailViewModel?
    
    var cocktails : [Cocktail] {
        return cocktailModelView?.getAllCocktails() ?? []
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var dataCollectionCell: DataCollectionView!
    var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //logoImageView.image = UIImage(named: "LOGO")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cocktails.count + 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCollectionView", for: indexPath)as? DataCollectionView
            cell?.searchBar.isUserInteractionEnabled = true
            return cell!
            
        }else if indexPath.row == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "labelCollectionView", for: indexPath)as? DataCollectionView
            cell?.titleText.isUserInteractionEnabled = false
            return cell!
            
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionView", for: indexPath)as? DataCollectionView
            
        
                let currentCocktail = cocktails[(indexPath.item - 2)]
                cell?.imageView.image = UIImage(named: currentCocktail.imageName)
                cell?.nameLabel.text = currentCocktail.cocktailName
            
            //cell?.imageView.image = UIImage(named: cocktailsArray[indexPath.item - 2].imageName)
            //cell?.nameLabel.text = cocktailsArray[indexPath.item - 2].cocktailName
            return cell!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        let position = indexPath.row
        if(position == 0){return CGSize(width: bounds.width, height: 90)}
        else if(position == 1){return CGSize(width: bounds.width, height: 40)}
        else{
            return CGSize(width: bounds.width/3, height: 160)}
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    /*func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let position = indexPath.row
        if(position == 0 || position == 1){return}
        let view = storyboard?.instantiateViewController(withIdentifier:"RecipeSceneViewController") as? RecipeSceneViewController
        view?.displayCocktail = diaryModelView.getCocktail(byIndex: indexPath.row - 2)
        self.navigationController?.pushViewController(view!, animated: true)
    }*/
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let selectedItem = self.collectionView.indexPathsForSelectedItems?.first else {return}
        
        
        let newDestination = segue.destination as? RecipeSceneViewController
        
        if let newDestination = newDestination{
            newDestination.displayCocktail = cocktails[(selectedItem.item - 2)]
        }
        
    }
}
