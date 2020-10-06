//
//  HomeViewController.swift
//  TalesAndSpirits
//
//  Created by Prodip Guha Roy on 23/8/20.
//  Copyright © 2020 RMIT. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, RefreshData{
    
    var cocktailViewModel: CocktailViewModel = CocktailViewModel()
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var dataCollectionCell: DataCollectionView!
    var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cocktailViewModel.delegate = self
    }
    
    func updateUIWithRestData(_ index: Int?) {
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cocktailViewModel.count + 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("row: \(indexPath.row) \t item: \(indexPath.item)")
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCollectionView", for: indexPath)as? DataCollectionView
            cell?.searchBar.isUserInteractionEnabled = true
            return cell!
            
        }else if indexPath.row == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "labelCollectionView", for: indexPath)as? DataCollectionView
            cell?.titleText.isUserInteractionEnabled = false
            return cell!
            
        }else if indexPath.row == 2{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionView", for: indexPath) as? DataCollectionView
            
            if let cell = cell{
                cell.imageView.image = cocktailViewModel.getRandomizeImage()
                cell.nameLabel.text = cocktailViewModel.getRandomizeText()
            }
            return cell!
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionView", for: indexPath)as? DataCollectionView
            
            if let cell = cell{
                cell.imageView.image = cocktailViewModel.getCocktailImage(byIndex: (indexPath.item - 3))
                cell.nameLabel.text = cocktailViewModel.getCocktailName(byIndex: (indexPath.item - 3))
            }
            
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let selectedItem = self.collectionView.indexPathsForSelectedItems?.first else {return}
        
        
        let newDestination = segue.destination as? RecipeSceneViewController
        
        if let newDestination = newDestination{
            newDestination.cocktailViewModel = cocktailViewModel
            
            if selectedItem.row == 2{
                cocktailViewModel.fetchRandomCocktail()
                
            }else{
                cocktailViewModel.fetchCocktailById(index: selectedItem.item - 3)
                newDestination.index = selectedItem.item - 3
            }
        }
        
    }
}
