//
//  RecipesViewController.swift
//  Reciplease
//
//  Created by Léo NICOLAS on 26/11/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

import UIKit

class RecipesViewController: UIViewController {
    
    //===================
    // View Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // Array of ingredients received from IngredientsVC
    var ingredients = [String]()
    
    // The recipe list gotten from the request
    var recipeList: RecipeList?

    // Identifier Name
    let segueIdentifier = "recipesToRecipeDetails"
    let cellIdentifier = "RecipeCell"

    //===================
    // View Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // The request which return a recipe list with the ingredients chosen
        manageActivityIndicator(shown: true)

        RecipeListService().getRecipeList(ingredients: ingredients) { (success, recipes) in
            self.manageActivityIndicator(shown: false)

            if success, let recipes = recipes, recipes.count > 0 {
                self.recipeList = recipes
                self.tableView.reloadData()

            } else if success, let recipes = recipes, recipes.count == 0 {
                UIAlertController().showAlert(title: "No Recipe Found", message: "Please, try a new search !", viewController: self)

            } else {
                UIAlertController().showAlert(title: "Warning!", message: "Invalid Request!", viewController: self)
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier,
            let recipeDetailsVC = segue.destination as? RecipeDetailsViewController {
            recipeDetailsVC.recipe = sender as? Recipe
        }
    }

    // Function which manages the display of the activity indicator
    private func manageActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        if shown {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}

// MARK: - TableView
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

        let recipe = recipes.hits[indexPath.row].recipe
        // Make a resquest for the recipe image
        RecipeListService().getRecipeImage(image: recipe.image) { (data) in
            // Display the recipe information
            cell.recipeView.configure(name: recipe.label,
                                      ingredients: recipe.ingredientLines.joined(separator: "; "),
                                      like: recipe.yield,
                                      time: recipe.totalTime,
                                      imageData: data)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let recipes = recipeList else { return }
        let recipe = recipes.hits[indexPath.row].recipe
        performSegue(withIdentifier: segueIdentifier, sender: recipe)
    }
}
