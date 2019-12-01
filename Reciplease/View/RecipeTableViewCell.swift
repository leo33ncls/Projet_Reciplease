//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Léo NICOLAS on 26/11/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var timeView: TimeView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        recipeImageView.layer.addSublayer(CustomShadowLayer(view: recipeImageView, shadowRadius: 60.0))
    }
    
    func configure(name: String, ingredients: String ,image: Data, like: Int, time: Int ) {
        recipeNameLabel.text = name
        ingredientsLabel.text = ingredients
        recipeImageView.image = UIImage(data: image)
        timeView.setViewValues(like: like, time: time)
    }
}
