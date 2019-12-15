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
    
    var recipe: Hit?
    var favoriteRecipe: FavoriteRecipe?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeImageView.layer.addSublayer(CustomShadowLayer(view: recipeImageView, shadowColor: UIColor.customGrey, shadowRadius: 50.0))
        directionButton.layer.cornerRadius = 5.0
        
        if let currentRecipe = recipe {
            recipeNameLabel.text = currentRecipe.recipe.label
            timeView.setViewValues(like: currentRecipe.recipe.yield, time: currentRecipe.recipe.totalTime)
            RecipeListService().getRecipeImage(image: currentRecipe.recipe.image) { (data) in
                if let data = data {
                    self.recipeImageView.image = UIImage(data: data)
                }
            }
        } else if let currentRecipe = favoriteRecipe {
            recipeNameLabel.text = currentRecipe.name
            timeView.setViewValues(like: Int(currentRecipe.like), time: Int(currentRecipe.time))
            RecipeListService().getRecipeImage(image: currentRecipe.image) { (data) in
                if let data = data {
                    self.recipeImageView.image = UIImage(data: data)
                }
            }
        } else {
            UIAlertController().showAlert(title: "Sorry!", message: "No recipe found!", viewController: self)
        }
        tableView.reloadData()
    }
    
    @IBAction func getDirections(_ sender: UIButton) {
        if let currentRecipe = recipe, let url = URL(string: currentRecipe.recipe.url) {
            UIApplication.shared.open(url)
        } else if let currentRecipe = favoriteRecipe, let urlString = currentRecipe.url,
            let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        } else {
            UIAlertController().showAlert(title: "Sorry!", message: "No direction available!", viewController: self)
        }
    }
    
    @IBAction func setRecipeAsFavorite(_ sender: UIBarButtonItem) {
        if let currentRecipe = recipe {
            saveRecipe(recipe: currentRecipe)
            
        } else if let currentRecipe = favoriteRecipe {
            removeRecipe(favoriteRecipe: currentRecipe)
        } else {
            UIAlertController().showAlert(title: "Sorry!", message: "No recipe to save!", viewController: self)
        }
    }
    
    private func saveRecipe(recipe: Hit) {
        let favoriteRecipe = FavoriteRecipe(context: AppDelegate.viewContext)
        favoriteRecipe.name = recipe.recipe.label
        favoriteRecipe.image = recipe.recipe.image
        favoriteRecipe.ingredients = recipe.recipe.ingredientLines.joined(separator: "; ")
        favoriteRecipe.like = Double(recipe.recipe.yield)
        favoriteRecipe.time = Double(recipe.recipe.totalTime)
        favoriteRecipe.url = recipe.recipe.url
        try? AppDelegate.viewContext.save()
    }
    
    private func removeRecipe(favoriteRecipe: FavoriteRecipe) {
        AppDelegate.viewContext.delete(favoriteRecipe)
        try? AppDelegate.viewContext.save()
    }
}

extension RecipeDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let currentRecipe = recipe {
            return currentRecipe.recipe.ingredientLines.count
        } else if let currentRecipe = favoriteRecipe, let ingredients = currentRecipe.ingredients {
            let ingredientsArray = ingredients.components(separatedBy: "; ")
            return ingredientsArray.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as? IngredientTableViewCell else {
            return UITableViewCell()
        }
        if let currentRecipe = recipe {
            let ingredient = currentRecipe.recipe.ingredientLines[indexPath.row]
            cell.configure(ingredient: ingredient)
            return cell
        } else if let currentRecipe = favoriteRecipe, let ingredients = currentRecipe.ingredients {
            let ingredientsArray = ingredients.components(separatedBy: "; ")
            cell.configure(ingredient: ingredientsArray[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
