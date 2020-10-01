//
//  SplitViewController.swift
//  TalesAndSpirits
//
//  Created by Henry Chin on 1/10/20.
//  Copyright © 2020 RMIT. All rights reserved.
//

import Foundation
import UIKit

class SplitViewController: NSObject, UISplitViewControllerDelegate {
    func splitViewController(_ svc: UISplitViewController,
                             willShow vc: UIViewController,
                             invalidating barButtonItem: UIBarButtonItem)
    {
        if let detailView = svc.viewControllers.first as? UINavigationController {
            svc.navigationItem.backBarButtonItem = nil
            detailView.topViewController?.navigationItem.leftBarButtonItem = nil
        }
    }
    
    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool
    {
        guard let navigationController = primaryViewController as? UINavigationController,
            let controller = navigationController.topViewController as? CocktailsViewController
        else {
                return true
        }
        
        return controller.collapseDetailViewController
    }
}
