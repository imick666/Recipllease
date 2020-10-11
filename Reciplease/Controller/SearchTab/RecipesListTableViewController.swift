//
//  RecipesListTableViewController.swift
//  Reciplease
//
//  Created by mickael ruzel on 08/10/2020.
//

import UIKit

class RecipesListTableViewController: UITableViewController {

    var dataSource: Recipes! {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "RecipesListTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constants.Cells.recipeCell)
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataSource?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.recipeCell) as? RecipesListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.recipe = dataSource[indexPath.row].recipe

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    // MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.Segues.recipe, sender: dataSource?[indexPath.row])
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segues.recipe {
            if let destination = segue.destination as? RecipeViewController {
                destination.recipe = sender as? Recipe
            }
        }
    }

}
