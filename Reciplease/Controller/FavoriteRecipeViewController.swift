//
//  FavoriteRecipeViewController.swift
//  Reciplease
//
//  Created by Léo NICOLAS on 09/12/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

import UIKit
import CoreData

class FavoriteRecipeViewController: UIViewController {

    //===================
    // View Properties
    @IBOutlet weak var tableView: UITableView!

    // Identifier Name
    let segueIdentifier = "favoriteToRecipeDetails"
    let cellIdentifier = "RecipeCell"

    //===================
    // View Cycles
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Show alert if no favorite recipe
        if FavoriteRecipe.all.count == 0 {
            UIAlertController().showAlert(title: "No favorite recipe!",
                                          message: "To set a recipe in favorite, click on the star at the top right",
                                          viewController: self)
        }
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier,
            let recipeDetailsVC = segue.destination as? RecipeDetailsViewController {
            recipeDetailsVC.recipe = sender as? Recipe
        }
    }
}

// MARK: - TableView
extension FavoriteRecipeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavoriteRecipe.all.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                       for: indexPath) as? RecipeTableViewCell else {
                                                        return UITableViewCell()
        }
        let recipe = FavoriteRecipe.all[indexPath.row]
        // Make a resquest for the recipe image
        RecipeListService().getRecipeImage(image: recipe.image) { (data) in
            // Display the recipe information
            cell.recipeView.configure(name: recipe.label,
                                      ingredients: recipe.ingredientLines.joined(separator: "; "),
                                      like: Int(recipe.yield),
                                      time: Int(recipe.totalTime),
                                      imageData: data)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = FavoriteRecipe.all[indexPath.row]
        performSegue(withIdentifier: segueIdentifier, sender: recipe)
    }
}
