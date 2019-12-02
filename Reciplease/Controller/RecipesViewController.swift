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

    override func viewDidLoad() {
        super.viewDidLoad()
        RecipeListService().getRecipeList(ingredients: ingredients) { (success, recipes) in
            if success, let recipes = recipes {
                self.recipeList = recipes
                self.tableView.reloadData()
            } else {
                let alertVC = UIAlertController(title: "Attention", message: "Requête Incorrect", preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertVC, animated: true, completion: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recipesToRecipeDetails", let recipeDetailsVC = segue.destination as? RecipeDetailsViewController {
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell",
                                                       for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        
        let recipe = recipes.hits[indexPath.row]
        RecipeListService().getRecipeImage(image: recipe.recipe.image) { (data) in
            if let imageData = data {
                cell.configure(name: recipe.recipe.label,
                               ingredients: self.getIngredients(ingredients: recipe.recipe.ingredientLines),
                               image: imageData,
                               like: recipe.recipe.yield,
                               time: recipe.recipe.totalTime)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let recipes = recipeList else { return }
        let recipe = recipes.hits[indexPath.row]
        performSegue(withIdentifier: "recipesToRecipeDetails", sender: recipe)
    }
    
    /*private func getImageForRecipe(image: String) -> UIImage {
        var recipeImage = #imageLiteral(resourceName: "recipeDefault")
        RecipeListService().getRecipeImage(image: image) { (data) in
            if let data = data, let imageData = UIImage(data: data) {
                recipeImage = imageData
            }
        }
        return recipeImage
    }*/
    
    private func getIngredients(ingredients: [String]) -> String {
        var ingredientsString = ""
        for i in 0..<ingredients.count {
            ingredientsString += ingredients[i]
        }
        return ingredientsString
    }
}
