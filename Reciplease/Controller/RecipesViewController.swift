//
//  RecipesViewController.swift
//  Reciplease
//
//  Created by Léo NICOLAS on 26/11/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

import UIKit

class RecipesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var ingredients = [String]()
    var recipeList: RecipeList?
    
    let segueIdentifier = "recipesToRecipeDetails"
    let cellIdentifier = "RecipeCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        RecipeListService().getRecipeList(ingredients: ingredients) { (success, recipes) in
            if success, let recipes = recipes {
                self.recipeList = recipes
                self.tableView.reloadData()
            } else {
                UIAlertController().showAlert(title: "Warning!", message: "Invalid Request!", viewController: self)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier, let recipeDetailsVC = segue.destination as? RecipeDetailsViewController {
            recipeDetailsVC.recipe = sender as? Hit
        }
    }
}


extension RecipesViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let recipe = recipeList else { return 0 }
        return recipe.hits.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let recipes = recipeList else { return UITableViewCell() }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                       for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        
        let recipe = recipes.hits[indexPath.row]
        RecipeListService().getRecipeImage(image: recipe.recipe.image) { (data) in
            cell.recipeView.configure(name: recipe.recipe.label,
                                      ingredients: recipe.recipe.ingredientLines.joined(separator: "; "),
                                      like: recipe.recipe.yield,
                                      time: recipe.recipe.totalTime,
                                      imageData: data)
        }
        return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let recipes = recipeList else { return }
        let recipe = recipes.hits[indexPath.row]
        performSegue(withIdentifier: segueIdentifier, sender: recipe)
    }
}
