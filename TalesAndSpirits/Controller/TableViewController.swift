//
//  TableViewController.swift
//  TalesAndSpirits
//
//  Created by PUJA on 4/9/20.
//  Copyright © 2020 RMIT. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var arrData = [1,2,3,4,5,6,7,8]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.nameText.text = "\(arrData[indexPath.row])"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "viewController")
        as! ViewController
        vc.strText = "\(arrData[indexPath.row])"
        splitViewController?.showDetailViewController(vc, sender: nil)
    }
}
