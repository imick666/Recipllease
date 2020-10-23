//
//  RecipesListTableViewController.swift
//  Reciplease
//
//  Created by mickael ruzel on 08/10/2020.
//

import UIKit
import SDWebImage

class RecipesListTableViewController: UITableViewController {

    // MARK: - Properties
    
    var dataSource: Recipes! {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - View LifeCircle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: Constants.nibName.recipeCell , bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constants.Cells.recipeCell)
        tableView.separatorStyle = .none
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.recipeCell) as? RecipesListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.recipe = dataSource[indexPath.row]

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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segues.recipe {
            if let destination = segue.destination as? RecipeViewController {
                destination.recipe = sender as? Recipe
            }
        }
    }
}
