//
//  IngredientTableViewCell.swift
//  Reciplease
//
//  Created by Léo NICOLAS on 26/11/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {

    // Outlet
    @IBOutlet weak var ingredientLabel: UILabel!

    // Function which sets an ingredient to the ingredientLabel
    func configure(ingredient: String) {
        ingredientLabel.text = "- \(ingredient)"
    }
}
