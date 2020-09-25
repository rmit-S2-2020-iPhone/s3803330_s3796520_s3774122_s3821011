//
//  HomeViewController.swift
//  TalesAndSpirits
//
//  Created by Prodip Guha Roy on 23/8/20.
//  Copyright © 2020 RMIT. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, RefreshData{
    
    
    //private let diaryModelView = CocktailViewModel()
    var cocktailViewModel: CocktailViewModel?
    
//    var cocktails : [Cocktail] {
//        return cocktailViewModel?.getAllCocktails() ?? []
//    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var dataCollectionCell: DataCollectionView!
    var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cocktailViewModel?.delegate = self
    }
    
    func updateUIWithRestData() {
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cocktailViewModel!.count + 2
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
            
        
            let currentCocktail: (cocktailName: String, image: UIImage?) = cocktailViewModel!.getCocktail(byIndex: (indexPath.item - 2))
                    //cocktails[(indexPath.item - 2)]
                cell?.imageView.image = currentCocktail.image
                cell?.nameLabel.text = currentCocktail.cocktailName
            
            //cell?.imageView.image = UIImage(named: cocktailsArray[indexPath.item - 2].imageName)
            //cell?.nameLabel.text = cocktailsArray[indexPath.item - 2].cocktailName
            return cell!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        let position = indexPath.row
        if(position == 0){return CGSize(width: bounds.width, height: 50)}
        else if(position == 1){return CGSize(width: bounds.width, height: 60)}
        else{
            return CGSize(width: bounds.width/2, height: 160)}
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
            //newDestination.displayCocktail = cocktailViewModel!.getCocktail(byIndex: (selectedItem.item - 2))
            cocktailViewModel?.fetchCocktailById(index: selectedItem.item - 2)
            newDestination.cocktailViewModel = cocktailViewModel
            newDestination.index = selectedItem.item - 2
                //cocktails[(selectedItem.item - 2)]
        }
        
    }
}
