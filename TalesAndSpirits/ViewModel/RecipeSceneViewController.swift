//
//  RecipeSceneViewController.swift
//  TalesAndSpirits
//
//  Created by Prodip Guha Roy on 3/9/20.
//  Copyright © 2020 RMIT. All rights reserved.
//

import UIKit

protocol FavouriteCocktailDelegate {
    func addCocktailAsFavorite(_ drinkId: String)
    func removeCocktailAsFavorite(_ drinkId: String)
}

class RecipeSceneViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, RefreshRecipeScene {
    
    
    //var cocktailViewModel: CocktailViewModel?
    var viewModel: RecipeSceneViewModel?
    var delegate: FavouriteCocktailDelegate?
    //var index: Int?
    
    @IBOutlet weak var cocktailNameLabel: UILabel!
    @IBOutlet weak var cocktailImageView: UIImageView!
    
    @IBOutlet weak var addNoteButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var drinkInfoTableView: UITableView!
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var preparationLabel: UILabel!
    
    @IBOutlet weak var personalNoteTextView: UITextView!
    
    private let defaultDisabledTextViewMessage = "Add this cocktail to MyDiary to add personal note"
    private let defaultEnabledTextViewMessage = "Add a personal note to your favorite cocktail"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //cocktailViewModel?.delegate = self
        viewModel?.delegate = self
        
        
        populateView()
        
        drinkInfoTableView.delegate = self
        drinkInfoTableView.dataSource = self
        
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    private func populateView(){
        personalNoteTextView.isEditable = false
        if let viewModel = viewModel{
            cocktailNameLabel.text = viewModel.getCocktailName()
            cocktailImageView.image = viewModel.getCocktailImage()
            preparationLabel.text = viewModel.getCocktailInstructions()
            if let isFavorite = viewModel.getCocktailIsFavorite(){
                if(isFavorite){
                    favoriteButton.setBackgroundImage(UIImage(named: "Star-filled"), for: .normal)
                    addNoteButton.isEnabled = true
                    
                    var personalNote = defaultEnabledTextViewMessage
                    if let note = viewModel.getCocktailPersonalizedNote(){
                        if !note.isEmpty{
                            personalNote = note
                        }
                    }
                    personalNoteTextView.text = personalNote
                    
                }else{
                    favoriteButton.setBackgroundImage(UIImage(named: "Star"), for: .normal)
                    addNoteButton.isEnabled = false
                    personalNoteTextView.text = defaultDisabledTextViewMessage
                }
            }
        }
    }
    
    func updateUI() {
        populateView()
        self.drinkInfoTableView.reloadData()
        self.ingredientsTableView.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount = 0
        if tableView == self.drinkInfoTableView{
            rowCount = 3
        }else if tableView == self.ingredientsTableView {
            if let viewModel = viewModel, let ingredients = viewModel.getCocktailIngredients() {
                rowCount = ingredients.count
            }
        }
        
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var finalCell =  UITableViewCell()
        
        if tableView == self.drinkInfoTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath)
            let infoLabel = cell.viewWithTag(1000) as? UILabel
            let infoLabel2 = cell.viewWithTag(1010) as? UILabel
            
            if let infoLabel = infoLabel, let infoLabel2 = infoLabel2, let viewModel = viewModel {
                if indexPath.row == 0{
                    infoLabel.text = viewModel.getCocktailCategory()
                    infoLabel2.text = "Category"
                }else if indexPath.row == 1{
                    var iBA = "none"
                    if let cocktailiBA = viewModel.getCocktailiBA(){
                        if !cocktailiBA.isEmpty{
                            iBA = cocktailiBA
                        }
                    }
                    infoLabel.text = iBA
                    infoLabel2.text = "iBA"
                }else if indexPath.row == 2{
                    infoLabel.text = viewModel.getCocktailGlassType()
                    infoLabel2.text = "Glass"
                }
            }
            
            finalCell = cell
        }else if tableView == self.ingredientsTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)
            let infoLabel = cell.viewWithTag(1001) as? UILabel
            let infoLabel2 = cell.viewWithTag(1020) as? UILabel
            
            if let infoLabel = infoLabel, let infoLabel2 = infoLabel2, let viewModel = viewModel, let ingredients = viewModel.getCocktailIngredients() {
                let currentIngredient: (name: String, quantity: String) = ingredients[indexPath.row]
                infoLabel.text = currentIngredient.name
                infoLabel2.text = currentIngredient.quantity
            }
            
            finalCell = cell
        }
        
        return finalCell
    }
    
    
    @IBAction func favoriteButtonPressed(_ sender: Any) {
        if favoriteButton.currentBackgroundImage == UIImage(named: "Star-filled"){
            showAlert("Once Removed all personal notes will be lost. Do you want to continue?")
            
        }else{
            favoriteButton.setBackgroundImage(UIImage(named: "Star-filled"), for: .normal)
            if let viewModel = viewModel{
                //viewModel.setCocktailAsFavorite(value: true)
                
                // TODO: Add cocktail to database
                if let drinkId = viewModel.getCocktailId(){
                    delegate?.addCocktailAsFavorite(drinkId)
                }
                
                //cocktailViewModel.setCocktailAsFavorite(index: index)
                addNoteButton.isEnabled = true
//                var note = defaultEnabledTextViewMessage
//                let personalNote = cocktailViewModel.getCocktailPersonalizedNote(byIndex: index)
//                if !personalNote.isEmpty{
//                    note = personalNote
//                }
                personalNoteTextView.text = defaultEnabledTextViewMessage
            }
            
        }
    }
    
    
    @IBAction func addNoteButtonPressed(_ sender: Any) {
        //Check if textview contains default message, if no add it to personal note
        
        if personalNoteTextView.text != defaultEnabledTextViewMessage{
            if let viewModel = viewModel{
                viewModel.setCocktailPersonalNote(note: personalNoteTextView.text)
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destination = segue.destination as? AddNotePopOverViewController
        
        if let destination = destination{
            destination.delegate = self
            destination.existingNote = personalNoteTextView.text
        }
        
    }
    
    func showAlert(_ message: String){
        let alert = UIAlertController(title: "Remove from MyDiary", message: message, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { action  in self.removeFavorite()
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        
        present(alert, animated: true)
        
    }
    
    func removeFavorite(){
        favoriteButton.setBackgroundImage(UIImage(named: "Star"), for: .normal)
        if let viewModel = viewModel{
            //viewModel.setCocktailAsFavorite(value: false)
            viewModel.setCocktailPersonalNote(note: "")
            // TODO: Delete cocktail from database
            if let drinkId = viewModel.getCocktailId(){
                delegate?.removeCocktailAsFavorite(drinkId)
            }
            //cocktailViewModel.removeCocktailFromFavorite(index: index)
        }
        addNoteButton.isEnabled = false
        personalNoteTextView.text = defaultDisabledTextViewMessage
    }
    
    
}

extension RecipeSceneViewController: AddNotePopOverDelegate{
    func updateNote(_ text: String) {
        personalNoteTextView.text = text
        if text != defaultEnabledTextViewMessage{
            if let viewModel = viewModel{
                viewModel.setCocktailPersonalNote(note: text)
            }
        }
    }
    
    
    
    
}
