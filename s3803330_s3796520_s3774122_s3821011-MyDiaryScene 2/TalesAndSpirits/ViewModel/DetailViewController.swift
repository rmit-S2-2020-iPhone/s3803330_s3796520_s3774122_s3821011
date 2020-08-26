//
//  ViewController.swift
//  TalesAndSpirits
//
//  Created by PUJA on 14/8/20.
//  Copyright © 2020 RMIT. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelText: UILabel!
    
    var ctail: Cocktail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    private func updateView() {
        guard let name = ctail?.imageName else { return }
        if let image = UIImage(named: name) {
            imageView.image = image
        }
        labelText.text = ctail?.cocktailName
    }
}
