//
//  IngredientsViewController.swift
//  Reciplease
//
//  Created by Léo NICOLAS on 19/11/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

import UIKit

class IngredientsViewController: UIViewController {

    @IBOutlet weak var ingredientsTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var ingredients = [String]()
    let segueIdentifier = "ingredientToRecipes"
    let cellIdentifier = "IngredientCell"
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier, let recipesVC = segue.destination as? RecipesViewController {
            recipesVC.ingredients = ingredients
        }
    }
    
    @IBAction func addIngredients(_ sender: UIButton) {
        guard let ingredient = ingredientsTextField.text else {
            UIAlertController().showAlert(title: "Warning!", message: "Please enter an ingredient!", viewController: self)
            return
        }
        ingredients.append(ingredient)
        tableView.reloadData()
    }
    
    @IBAction func clearList(_ sender: UIButton) {
        ingredients.removeAll()
        tableView.reloadData()
    }
    
    @IBAction func searchRecipes(_ sender: UIButton) {
        guard ingredients.count >= 1 else {
            UIAlertController().showAlert(title: "Warning!", message: "You didn't enter any ingredients!", viewController: self)
            return
        }
        performSegue(withIdentifier: segueIdentifier, sender: nil)
    }
}


extension IngredientsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? IngredientTableViewCell else {
            return UITableViewCell()
        }
        let ingredient = ingredients[indexPath.row]
        cell.configure(ingredient: ingredient)
        return cell
    }
}
