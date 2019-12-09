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

    @IBOutlet weak var tableView: UITableView!
    
    let segueIdentifier = "favoriteToRecipeDetails"
    let cellIdentifier = "RecipeCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier, let recipeDetailsVC = segue.destination as? RecipeDetailsViewController {
            recipeDetailsVC.favoriteRecipe = sender as? FavoriteRecipe
        }
    }
}

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
        RecipeListService().getRecipeImage(image: recipe.image) { (data) in
            cell.recipeView.configure(name: recipe.name,
                                      ingredients: recipe.ingredients,
                                      like: Int(recipe.like),
                                      time: Int(recipe.time),
                                      imageData: data)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipe = FavoriteRecipe.all[indexPath.row]
        performSegue(withIdentifier: segueIdentifier, sender: recipe)
    }
}
