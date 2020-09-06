//
//  AddNotePopOverViewController.swift
//  TalesAndSpirits
//
//  Created by Prodip Guha Roy on 6/9/20.
//  Copyright © 2020 RMIT. All rights reserved.
//

import UIKit

protocol AddNotePopOverDelegate{
    func updateNote(_ text: String)
}

class AddNotePopOverViewController: UIViewController {

    @IBOutlet weak var addNoteTextView: UITextView!
    
    var delegate: AddNotePopOverDelegate?
    var existingNote: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let text = existingNote {
            addNoteTextView.text = text
        }
        // Do any additional setup after loading the view.
    }
    

    @IBAction func saveButtonPressed(_ sender: Any) {
        if delegate != nil{
            delegate?.updateNote(addNoteTextView.text)
            dismiss(animated: true, completion: nil)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
