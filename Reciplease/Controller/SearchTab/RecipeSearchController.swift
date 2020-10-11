//
//  RecipeSearchController.swift
//  Reciplease
//
//  Created by mickael ruzel on 04/10/2020.
//

import UIKit

class RecipeSearchController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var addIngredientTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addIngredientButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    
    // MARK: - Properties
    private let networkServices = NetworkServices()
    
    var dataSource = [String]() {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - ViewLife Circle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButton()
        
        // Addd footer for tableview
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 84))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupTextField()
    }
    
    // MARK: - Methodes
    
    private func setupButton() {
        addIngredientButton.rounded()
        clearButton.rounded()
        searchButton.rounded()
    }
    
    private func setupTextField() {
        addIngredientTextField.borderStyle = .none
        let underline = UIView()
        underline.backgroundColor = #colorLiteral(red: 0.5418370962, green: 0.5419180989, blue: 0.5418193936, alpha: 1)
        underline.frame = CGRect(x: addIngredientTextField.bounds.minX, y: addIngredientTextField.bounds.maxY - 3, width: addIngredientTextField.bounds.width, height: 2)
        underline.alpha = 0.5
        addIngredientTextField.addSubview(underline)
    }

    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segues.RecipesList {
            guard let destination = segue.destination as? RecipesListTableViewController else {
                return
            }
            destination.dataSource = sender as? Recipes
        }
    }    
    
    // MARK: - Actions
    
    @IBAction func addIngredientButtonTapped(_ sender: Any) {
        guard let ingredient = addIngredientTextField.text else {
            return
        }
        dataSource.append(ingredient)
        addIngredientTextField.text = nil
    }
    @IBAction func clearButtonTapped(_ sender: Any) {
        dataSource = []
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        networkServices.getRecipes(q: dataSource) { (result) in
            switch result {
            case .failure(let error):
                print(error.description)
            case .success(let data):
                self.performSegue(withIdentifier: Constants.Segues.RecipesList, sender: data)
            }
        }
    }
}

// MARK: - Extension TableView

extension RecipeSearchController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard dataSource.count != 0 else {
            return 1
        }
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.font = UIFont(name: "Chalkduster", size: 18)
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .clear
        
        if dataSource.count == 0 {
            cell.textLabel?.text = "Please, add some ingredients"
            cell.textLabel?.textAlignment = .center
        } else {
            cell.textLabel?.text = "- " + dataSource[indexPath.row]
            cell.textLabel?.textAlignment = .left
        }
        
        return cell
    }
    
    // MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard dataSource != [] else {
            return
        }
        dataSource.remove(at: indexPath.row)
    }
}
