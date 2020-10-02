//
//  AddNewCocktail.swift
//  TalesAndSpirits
//
//  Created by GAJSA on 2/10/20.
//  Copyright © 2020 RMIT. All rights reserved.
//
import Foundation
import UIKit
import AVKit
import MobileCoreServices

class ViewController: UIViewController
{
    
    @IBOutlet weak var imageView: UIImageView!
  

    @IBOutlet weak var takePictureButton: UIButton!

    
    /* AVKit - This will be instantiated in code and added as a subview
     Also available from your object explorer to add to the storyboard.
     */
    var avPlayerViewController: AVPlayerViewController!
    
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
            takePictureButton.isHidden = true
        }
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
    
    // Use the image picker controller for taking a picture
    @IBAction func shootPictureOrVideo(_ sender: UIButton) {
        pickMediaFromSource(UIImagePickerControllerSourceType.camera)
    }
    
    
    // Use the Image Picker Controller for selecting an image from
    // the users library.
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
    
    
}

extension ViewController: UIImagePickerControllerDelegate
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


extension ViewController:UINavigationControllerDelegate{}

