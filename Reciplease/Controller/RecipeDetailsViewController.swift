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
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var directionButton: UIButton!
    @IBOutlet weak var timeView: TimeView!
    @IBOutlet weak var rightBarButtonItem: UIBarButtonItem!
    
    var recipe: Recipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeImageView.layer.addSublayer(CustomShadowLayer(view: recipeImageView, shadowColor: UIColor.customGrey, shadowRadius: 50.0))
        directionButton.layer.cornerRadius = 5.0
        
        if let currentRecipe = recipe {
            setFavoriteButtonColor(recipe: currentRecipe)
            setValues(recipe: currentRecipe)
        } else {
            UIAlertController().showAlert(title: "Sorry!", message: "No recipe found!", viewController: self)
        }
        
        tableView.reloadData()
    }
    
    private func setFavoriteButtonColor(recipe: Recipe) {
        if FavoriteRecipe.containsRecipe(recipe: recipe) {
            rightBarButtonItem.tintColor = UIColor.customGreen
        } else {
            rightBarButtonItem.tintColor = UIColor.white
        }
    }
    
    private func setValues(recipe: Recipe) {
        recipeNameLabel.text = recipe.label
        timeView.setViewValues(like: recipe.yield, time: recipe.totalTime)
        RecipeListService().getRecipeImage(image: recipe.image) { (data) in
            if let data = data {
                self.recipeImageView.image = UIImage(data: data)
            } else {
                self.recipeImageView.image = #imageLiteral(resourceName: "recipeDefault")
            }
        }
    }
    
    @IBAction func getDirections(_ sender: UIButton) {
        guard let currentRecipe = recipe, let url = URL(string: currentRecipe.url) else {
            UIAlertController().showAlert(title: "Sorry!", message: "No direction available!", viewController: self)
            return
        }
        UIApplication.shared.open(url)
    }
    
    @IBAction func setRecipeAsFavorite(_ sender: UIBarButtonItem) {
        if let currentRecipe = recipe, !FavoriteRecipe.containsRecipe(recipe: currentRecipe) {
            FavoriteRecipe.saveRecipe(recipe: currentRecipe)
            rightBarButtonItem.tintColor = UIColor.customGreen
        } else if let currentRecipe = recipe, FavoriteRecipe.containsRecipe(recipe: currentRecipe) {
            FavoriteRecipe.removeRecipe(recipe: currentRecipe)
            rightBarButtonItem.tintColor = UIColor.white
        } else {
            UIAlertController().showAlert(title: "Sorry!", message: "No recipe to save!", viewController: self)
        }
    }
}

extension RecipeDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let currentRecipe = recipe else { return 0 }
        return currentRecipe.ingredientLines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let currentRecipe = recipe else { return UITableViewCell() }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as? IngredientTableViewCell else {
            return UITableViewCell()
        }
        
        let ingredient = currentRecipe.ingredientLines[indexPath.row]
        cell.configure(ingredient: ingredient)
        return cell
    }
}
