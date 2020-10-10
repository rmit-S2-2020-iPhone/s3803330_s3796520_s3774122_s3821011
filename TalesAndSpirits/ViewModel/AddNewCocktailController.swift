//
//  AddNewCocktailController.swift
//  TalesAndSpirits
//
//  Created by GAJSA on 2/10/20.
//  Copyright © 2020 RMIT. All rights reserved.
//
import Foundation
import UIKit
import AVKit
import MobileCoreServices

protocol UserDefinedCocktail{
    func addCocktail(_ cocktailDetails: [String: String], image: UIImage?)
}

class AddNewCocktailController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    /*
     //Image picker Implementation
 
 */
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var takePictureButton: UIButton!
    var avPlayerViewController: AVPlayerViewController!
    
    var delegate: UserDefinedCocktail?
    
    var image: UIImage?
    var movieURL: URL?
    var lastChosenMediaType: String?
    
    // Does not get called when returning after selecting the
    // media to display.
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // If the camera source (i.e. simulator) is not available, then
        // hide the take picture button.
        if !UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.camera) {
            takePictureButton.isEnabled = false
        }
        
       // cellView.te = "\(AddNewCocktailController.cellCount)"
        tableView.delegate = self
        tableView.dataSource = self
        self.RecipeText.layer.borderWidth = 1
        self.NoteTextView.layer.borderWidth = 1
        self.RecipeText.layer.borderColor = UIColor.lightGray.cgColor
        self.NoteTextView.layer.borderColor = UIColor.lightGray.cgColor
        RecipeText.text = "Enter recipe here"
        RecipeText.textColor = UIColor.lightGray
        NoteTextView.text = "Enter notes here"
        NoteTextView.textColor = UIColor.lightGray
        RecipeText.layer.cornerRadius = 5
        RecipeText.clipsToBounds = true
        NoteTextView.layer.cornerRadius = 5
        NoteTextView.clipsToBounds = true
        imageView.image = UIImage(named: "no_image_available")
    }
    
    // When returning to the app, update the display with the
    // chosen media type
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateDisplay()
    }
    
    func updateDisplay() {
        
        // optional, so if let used to unwrap.
        if let mediaType = lastChosenMediaType {
            
            // if the media chosen is an image, then get the
            // image and display it.
            
            // MobileCore Services Package
            if mediaType == (kUTTypeImage as NSString) as String {
                imageView.image = image!
                imageView.isHidden = false
                if avPlayerViewController != nil {
                    avPlayerViewController!.view.isHidden = true
                }
                
                // Otherwise the media chosen is a video
            } else if mediaType == (kUTTypeMovie as NSString) as String {
                if avPlayerViewController == nil {
                    // Instantiate a view for displaying the video
                    avPlayerViewController = AVPlayerViewController()
                    let avPlayerView = avPlayerViewController!.view
                    avPlayerView?.frame = imageView.frame
                    avPlayerView?.clipsToBounds = true
                    view.addSubview(avPlayerView!)
                }
                
                if let url = movieURL {
                    imageView.isHidden = true
                    avPlayerViewController.player = AVPlayer(url: url)
                    avPlayerViewController!.view.isHidden = false
                    avPlayerViewController!.player!.play()
                }
            }
        }
    }
    
    
    @IBAction func shootPicture(_ sender: Any) {
        pickMediaFromSource(UIImagePickerControllerSourceType.camera)
        
    }
   
    
    @IBAction func selectExistingPictureOrVideo(_ sender: UIButton) {
        pickMediaFromSource(UIImagePickerControllerSourceType.photoLibrary)
    }
    
    // This method gets called by the action methods to select
    // what type of media the user wants.
    func pickMediaFromSource(_ sourceType:UIImagePickerControllerSourceType)
    {
        
        if UIImagePickerController.isSourceTypeAvailable(sourceType)
            
        {
            // Instantiate an image picker
            let picker = UIImagePickerController()
            
            // Display the media types avaialble on the picker
            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: sourceType)!
            
            // Set delegate to self for system method calls.
            // This needs to be the delegate for both the picker
            // controller and the navigation controller.
            picker.delegate = self
            
            // Is the user allowed to edit the media
            picker.allowsEditing = true
            picker.sourceType = sourceType
            
            // Present the picker to the user.
            present(picker, animated: true, completion: nil)
        }
            // Otherwise display an error message
        else
        {
            let alertController = UIAlertController(title:"Error accessing media",message: "Unsupported media source.", preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    
    
    
    /*
     Ingredient table implementation
     
     
     */
    static var cellCount: Int = 1
    
    @IBOutlet weak var tableView: UITableView!
    
   
    
    @IBAction func addButtonPressed(_ sender: Any) {
        AddNewCocktailController.cellCount += 1
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: AddNewCocktailController.cellCount-1, section: 0)], with: .automatic)
        tableView.endUpdates()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AddNewCocktailController.cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell", for: indexPath)
        return cell;
    }
    
    //Adding default text
    //UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 150, 200)];
//    let recipeTextField = addRecipe
//    .placeholderText = @"Enter your text here";
    //[self.view addSubview textField];
   // var placeholder: String? { get set }

    
    
    @IBOutlet weak var RecipeText: UITextView!
    
    @IBOutlet weak var NoteTextView: UITextView!
    
    @IBOutlet weak var cocktailNameTextField: UITextField!
    
    @IBOutlet weak var categoryTextField: UITextField!
    
    @IBOutlet weak var iBATextField: UITextField!
    
    @IBOutlet weak var glassTextField: UITextField!
   
    @IBAction func SaveNewCocktail(_ sender: Any) {

        
        print("saved button clicked")
        //Validation here
        //Fetch all the data input
        var cocktailDetails: [String: String] = [:]
        
        if let name = cocktailNameTextField.text{
            cocktailDetails["name"] = name
            
            
            print(imageView.image)
            delegate?.addCocktail(cocktailDetails, image: imageView.image)
        }
        
        if let category = categoryTextField.text{
            cocktailDetails["category"] = category
            delegate?.addCocktail(cocktailDetails, image: imageView.image)
        }
        
        if let iBA = iBATextField.text{
            cocktailDetails["iBA"] = iBA
            delegate?.addCocktail(cocktailDetails, image: imageView.image)
        }
        
        if let glass = glassTextField.text{
            cocktailDetails["glass"] = glass
            delegate?.addCocktail(cocktailDetails, image: imageView.image)
        }
        
        if let recipe = RecipeText.text{
            cocktailDetails["recipe"] = recipe
            delegate?.addCocktail(cocktailDetails, image: imageView.image)
        }
        
        if let note = NoteTextView.text{
            cocktailDetails["note"] = note
            delegate?.addCocktail(cocktailDetails, image: imageView.image)
        }
        
        
    }
    
    
    
}


extension AddNewCocktailController: UIImagePickerControllerDelegate
{
    // Delegate method to process once the media has been selected
    // by the user.
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        lastChosenMediaType = info[UIImagePickerControllerMediaType] as? String
        
        // Set the variable to the data retrieved.
        if let mediaType = lastChosenMediaType {
            if mediaType == (kUTTypeImage as NSString) as String {
                image = info[UIImagePickerControllerEditedImage] as? UIImage
                saveImage(image: image!, path: "test")
                
            } else if mediaType == (kUTTypeMovie as NSString) as String {
                movieURL = info[UIImagePickerControllerMediaURL] as? URL
            }
        }
        
        // Dismiss the picker to return to the apps view
        picker.dismiss(animated: true, completion: nil)
    }
    
    func saveImage (image: UIImage, path: String)
    {
        let pngImageData = UIImagePNGRepresentation(image)
        
        let docDir = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        let imageUniqueName : Int64 = Int64(NSDate().timeIntervalSince1970 * 1000);
        
        var filePath = docDir.appendingPathComponent("\(imageUniqueName).png");
        
        do{
            try pngImageData?.write(to : filePath , options : .atomic)
            
        }catch{
            print("couldn't write image")
        }
        
        /* Test to see if the image was written */
        filePath = docDir.appendingPathComponent("\(imageUniqueName).png");
        
        if FileManager.default.fileExists(atPath: filePath.path){
            
            if let _ = UIImage(contentsOfFile : filePath.path){
                
                let confirmImage = UIImage(named : filePath.path)
                print(confirmImage!.size)
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion:nil)
    }
}


extension AddNewCocktailController:UINavigationControllerDelegate{}
