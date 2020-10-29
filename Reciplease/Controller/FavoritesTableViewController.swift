//
//  FavoritesTableViewController.swift
//  Reciplease
//
//  Created by mickael ruzel on 18/10/2020.
//

import UIKit

final class FavoritesTableViewController: UITableViewController {

    // MARK: - Properties
    
    private var coreData: CoreDataManager?
    
    private var dataSource: Recipes?
    
    // MARK: - ViewLife Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: Constants.nibName.recipeCell, bundle: nil), forCellReuseIdentifier: Constants.Cells.recipeCell)
        tableView.separatorStyle = .none
        
        // Setup CoreDataManager
        guard let appDel = UIApplication.shared.delegate as? AppDelegate else { return }
        coreData = CoreDataManager(context: appDel.persistentContainer.viewContext)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }

    // MARK: - Methodes
    
    private func reloadData() {
        dataSource = coreData?.allRecipes
        
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.recipeCell, for: indexPath) as? RecipesListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.recipe = dataSource?[indexPath.row]
        
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
        return dataSource?.count != 0 ? 0 : 200
    }

    // MARK: - TableView Delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let recipe = dataSource?[indexPath.row] else { return }
        
        performSegue(withIdentifier: Constants.Segues.favRecipeSegue, sender: recipe)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segues.favRecipeSegue {
            guard let destination = segue.destination as? RecipeViewController else { return }
            destination.recipe = sender as? Recipe
        }
    }
}
