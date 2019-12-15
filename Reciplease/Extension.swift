//
//  Extension.swift
//  Reciplease
//
//  Created by Léo NICOLAS on 09/12/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    public class var customGrey: UIColor {
        return UIColor(red: 51/255, green: 47/255, blue: 46/255, alpha: 1.0)
    }
    
    public class var customGreen: UIColor {
        return UIColor(red: 19/255, green: 127/255, blue: 77/255, alpha: 1.0)
    }
}

extension UIAlertController {
    func showAlert(title: String, message: String, viewController: UIViewController) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        viewController.present(alertVC, animated: true, completion: nil)
    }
}