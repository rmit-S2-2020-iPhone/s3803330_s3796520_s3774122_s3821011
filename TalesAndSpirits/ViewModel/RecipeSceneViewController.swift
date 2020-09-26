//
//  RecipeSceneViewController.swift
//  TalesAndSpirits
//
//  Created by Prodip Guha Roy on 3/9/20.
//  Copyright © 2020 RMIT. All rights reserved.
//

import UIKit

class RecipeSceneViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, RefreshData {
    
    //var displayCocktail: Cocktail?
    var cocktailViewModel: CocktailViewModel?
    var index: Int?
    
    //    var displayCocktail : Cocktail? {
    //        guard let index = index, let cocktailViewModel = cocktailViewModel  else{ return nil }
    //        return cocktailViewModel.getCocktail(byIndex: index)
    //    }
    
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
        cocktailViewModel?.delegate = self
        
        populateView()
        
        drinkInfoTableView.delegate = self
        drinkInfoTableView.dataSource = self
        
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    private func populateView(){
        personalNoteTextView.isEditable = false
        if let cocktailViewModel = cocktailViewModel, let index = index {
            cocktailNameLabel.text = cocktailViewModel.getCocktailName(byIndex: index)
            cocktailImageView.image = cocktailViewModel.getCocktailImage(byIndex: index)
            preparationLabel.text = cocktailViewModel.getCocktailInstructions(byIndex: index)
            if cocktailViewModel.getCocktailIsFavorite(byIndex: index){
                favoriteButton.setBackgroundImage(UIImage(named: "Star-filled"), for: .normal)
                addNoteButton.isEnabled = true
                let personalNote = cocktailViewModel.getCocktailPersonalizedNote(byIndex: index)
                if !personalNote.isEmpty{
                    personalNoteTextView.text = personalNote
                }else{
                    personalNoteTextView.text = defaultEnabledTextViewMessage
                }
            }else{
                favoriteButton.setBackgroundImage(UIImage(named: "Star"), for: .normal)
                addNoteButton.isEnabled = false
                personalNoteTextView.text = defaultDisabledTextViewMessage
            }
        }
    }
    
    func updateUIWithRestData() {
        populateView()
        self.drinkInfoTableView.reloadData()
        self.ingredientsTableView.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount = 0
        if tableView == self.drinkInfoTableView{
            rowCount = 3
        }else if tableView == self.ingredientsTableView {
            if let cocktailViewModel = cocktailViewModel, let index = index {
                rowCount = cocktailViewModel.getCocktailIngredients(byIndex: index).count
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
            
            if let infoLabel = infoLabel, let infoLabel2 = infoLabel2, let cocktailViewModel = cocktailViewModel, let index = index {
                if indexPath.row == 0{
                    infoLabel.text = cocktailViewModel.getCocktailCategory(byIndex: index)
                    infoLabel2.text = "Category"
                }else if indexPath.row == 1{
                    let iBA = cocktailViewModel.getCocktailiBA(byIndex: index)
                    if iBA.isEmpty{
                        infoLabel.text = "none"
                    }else{
                        infoLabel.text = iBA
                    }
                    infoLabel2.text = "iBA"
                }else if indexPath.row == 2{
                    infoLabel.text = cocktailViewModel.getCocktailGlassType(byIndex: index)
                    infoLabel2.text = "Glass"
                }
            }
            
            finalCell = cell
        }else if tableView == self.ingredientsTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)
            let infoLabel = cell.viewWithTag(1001) as? UILabel
            let infoLabel2 = cell.viewWithTag(1020) as? UILabel
            
            if let infoLabel = infoLabel, let infoLabel2 = infoLabel2, let cocktailViewModel = cocktailViewModel, let index = index {
                let ingredients: [(name: String, quantity: String)] = cocktailViewModel.getCocktailIngredients(byIndex: index)
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
            if let cocktailViewModel = cocktailViewModel, let index = index{
                cocktailViewModel.setCocktailAsFavorite(byIndex: index, value: true)
                addNoteButton.isEnabled = true
                var note = defaultEnabledTextViewMessage
                let personalNote = cocktailViewModel.getCocktailPersonalizedNote(byIndex: index)
                    if !personalNote.isEmpty{
                        note = personalNote
                    }
                personalNoteTextView.text = note
            }
            
        }
    }
    
    
    @IBAction func addNoteButtonPressed(_ sender: Any) {
        //Check if textview contains default message, if no add it to personal note
        
        if personalNoteTextView.text != defaultEnabledTextViewMessage{
            if let cocktailViewModel = cocktailViewModel, let index = index{
                cocktailViewModel.setCocktailPersonalNote(byIndex: index, note: personalNoteTextView.text)
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
        
        //alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        
        present(alert, animated: true)
        
    }
    
    func removeFavorite(){
        favoriteButton.setBackgroundImage(UIImage(named: "Star"), for: .normal)
        if let cocktailViewModel = cocktailViewModel, let index = index{
            cocktailViewModel.setCocktailAsFavorite(byIndex: index, value: false)
            cocktailViewModel.setCocktailPersonalNote(byIndex: index, note: "")
        }
        addNoteButton.isEnabled = false
        personalNoteTextView.text = defaultDisabledTextViewMessage
    }
    
    
}

extension RecipeSceneViewController: AddNotePopOverDelegate{
    func updateNote(_ text: String) {
        personalNoteTextView.text = text
        if text != defaultEnabledTextViewMessage{
            if let cocktailViewModel = cocktailViewModel, let index = index{
                cocktailViewModel.setCocktailPersonalNote(byIndex: index, note: text)
            }
        }
    }
    
    
    
    
}
