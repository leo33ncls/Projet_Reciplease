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
}

extension RecipesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let recipe = recipeList else {
            return 0
        }
        return recipe.hits.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let recipes = recipeList else {
            return UITableViewCell()
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        let recipe = recipes.hits[indexPath.row]
        /*cell.configure(name: recipe.recipe.label,
                       ingredients: recipe.recipe.ingredientLines[0],
                       image: ,
                       like: 0,
                       time: recipe.recipe.totalTime)*/
        return cell
    }
}
