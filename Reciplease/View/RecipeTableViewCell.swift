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
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeImageView: UIImageView!
    @IBOutlet weak var darkBackground: UIView!
    @IBOutlet weak var likeAndTimeView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        darkBackground.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        likeAndTimeView.layer.cornerRadius = 5.0
    }
    
    func configure(name: String, ingredients: String ,image: Data, like: Int, time: Int ) {
        recipeNameLabel.text = name
        ingredientsLabel.text = ingredients
        recipeImageView.image = UIImage(data: image)
        likeLabel.text = String(like)
        if time == 0 {
            timeLabel.text = "/"
        } else {
            timeLabel.text = String(time) + "m"
        }
    }
}
