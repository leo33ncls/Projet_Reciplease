//
//  RecipeDetailsViewController.swift
//  Reciplease
//
//  Created by Léo NICOLAS on 01/12/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

import UIKit

class RecipeDetailsViewController: UIViewController {
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    
    var recipe: Hit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeImageView.layer.addSublayer(CustomShadowLayer(view: recipeImageView, shadowRadius: 50.0))
        if let currentRecipe = recipe {
            recipeNameLabel.text = currentRecipe.recipe.label
            RecipeListService().getRecipeImage(image: currentRecipe.recipe.image) { (data) in
                if let data = data {
                    self.recipeImageView.image = UIImage(data: data)
                }
            }
        } else {
            let alertVC = UIAlertController(title: "Désolé", message: "Aucune recette trouvée", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
}
