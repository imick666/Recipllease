//
//  FavoritesTableViewController.swift
//  Reciplease
//
//  Created by mickael ruzel on 18/10/2020.
//

import UIKit

class FavoritesTableViewController: UITableViewController {

    // MARK: - Properties
    
    private let coreData = CoreDataManager()
    
    private var dataSource: [StoredRecipe]?
    
    // MARK: - ViewLife Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: Constants.nibName.recipeCell, bundle: nil), forCellReuseIdentifier: Constants.Cells.recipeCell)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }

    // MARK: - Methodes
    
    private func reloadData() {
        dataSource = coreData.allRecipes
        
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataSource?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.recipeCell, for: indexPath) as? RecipesListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.storedRecipe = dataSource?[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel(frame: view.frame)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "You can add some recipes in tapping the star"
        label.font = UIFont(name: "Chalkduster", size: 18)
        label.textColor = .white

        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard dataSource?.count != 0 else {
            return 200
        }
        
        return 0
    }

    // MARK: - TableView Delegate
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let recipe = dataSource?[indexPath.row] else {
                return
            }
            coreData.deleteRecipe(recipe)
            
            reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let recipe = dataSource?[indexPath.row] else {
            return
        }
        
        performSegue(withIdentifier: Constants.Segues.favRecipeSegue, sender: recipe)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segues.favRecipeSegue {
            guard let destination = segue.destination as? RecipeViewController else {
                return
            }
            destination.storedRecipe = sender as? StoredRecipe
        }
    }
}
