//
//  IngredientsViewController.swift
//  Reciplease
//
//  Created by Léo NICOLAS on 19/11/2019.
//  Copyright © 2019 Léo NICOLAS. All rights reserved.
//

import UIKit

class IngredientsViewController: UIViewController {

    //===================
    // View Properties

    // Outlet
    @IBOutlet weak var ingredientsTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchRecipesButton: UIButton!
    @IBOutlet weak var addIngredientButton: UIButton!
    @IBOutlet weak var clearListButton: UIButton!
    
    // An array of the ingredients chosen by the user
    var ingredients = [String]()
    
    // Identifier Name
    let segueIdentifier = "ingredientToRecipes"
    let cellIdentifier = "IngredientCell"

    //===================
    // View Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        searchRecipesButton.layer.cornerRadius = 2.0
        searchRecipesButton.titleLabel?.adjustsFontSizeToFitWidth = true
        addIngredientButton.layer.cornerRadius = 2.0
        clearListButton.layer.cornerRadius = 2.0
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier, let recipesVC = segue.destination as? RecipesViewController {
            recipesVC.ingredients = ingredients
        }
    }

    //===================
    // View Actions

    // Action which adds an ingredient in the array ingredients
    @IBAction func addIngredients(_ sender: UIButton) {
        guard let ingredient = ingredientsTextField.text else {
            UIAlertController().showAlert(title: "Warning!",
                                          message: "Please enter an ingredient!",
                                          viewController: self)
            return
        }
        ingredients.append(ingredient)
        ingredientsTextField.text = ""
        tableView.reloadData()
    }

    // Action which removes all the ingredients in the array
    @IBAction func clearList(_ sender: UIButton) {
        ingredients.removeAll()
        tableView.reloadData()
    }
    
    // Action which perform a segue
    @IBAction func searchRecipes(_ sender: UIButton) {
        guard ingredients.count >= 1 else {
            UIAlertController().showAlert(title: "Warning!",
                                          message: "You didn't enter any ingredients!",
                                          viewController: self)
            return
        }
        performSegue(withIdentifier: segueIdentifier, sender: nil)
    }
}

// MARK: - TableView
extension IngredientsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            as? IngredientTableViewCell else {
            return UITableViewCell()
        }
        let ingredient = ingredients[indexPath.row]
        // Display an ingredient in a custom cell
        cell.configure(ingredient: ingredient)
        return cell
    }
}

// MARK: - Keyboard
extension IngredientsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Action that dismiss the keyboard when the user taps on the main view
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        ingredientsTextField.resignFirstResponder()
    }
}
