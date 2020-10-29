//
//  RecipeSearchController.swift
//  Reciplease
//
//  Created by mickael ruzel on 04/10/2020.
//

import UIKit

final class RecipeSearchController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var addIngredientTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addIngredientButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    
    // MARK: - Properties
    
    private let networkServices = NetworkServices()
    private var frameUnderline: CGRect {
        let frame = CGRect(x: addIngredientTextField.bounds.minX, y: addIngredientTextField.bounds.maxY - 3, width: addIngredientTextField.bounds.width, height: 2)
        return frame
    }
    private var textFieldUnderline: UIView = {
        let underline = UIView()
        underline.backgroundColor = #colorLiteral(red: 0.5418370962, green: 0.5419180989, blue: 0.5418193936, alpha: 1)
        underline.alpha = 0.5
        return underline
    }()
    
    var dataSource = [String]() {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - ViewLife Circle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButtons()
        
        setUpTableView()
        
        setupTextField()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textFieldUnderline.frame = frameUnderline
    }
    
    // MARK: - Methodes
    
    private func setUpTableView() {
        tableView.separatorStyle = .none

    }
    
    private func setupTextField() {
        addIngredientTextField.delegate = self
        addIngredientTextField.borderStyle = .none
        addIngredientTextField.addSubview(textFieldUnderline)
    }
    
    private func setupButtons() {
        addIngredientButton.round(background: #colorLiteral(red: 0.268276602, green: 0.5838349462, blue: 0.3624466658, alpha: 1), title: "Add", textColor: .white)
        clearButton.round(background: #colorLiteral(red: 0.5418370962, green: 0.5419180989, blue: 0.5418193936, alpha: 1), title: "Clear", textColor: .white)
        searchButton.round(background: #colorLiteral(red: 0.268276602, green: 0.5838349462, blue: 0.3624466658, alpha: 1), title: "Search for recipes", textColor: .white)
    }

    // MARK: - Navigation
    
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
        guard let ingredients = addIngredientTextField.text?.transformToArray else { return }
        for ingredient in ingredients {
            guard ingredient.lowercased().ingredientNameIsCorrect else {
                showAlert(title: "Erreur", message: "Please, enter a correct entry")
                continue
            }
            dataSource.append(ingredient.lowercased().trimmingCharacters(in: .whitespacesAndNewlines))
        }
        addIngredientTextField.text = nil
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        dataSource = []
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        networkServices.getRecipes(q: dataSource) { (result) in
            switch result {
            case .failure(let error):
                self.showAlert(title: "Error", message: error.description)
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
        return dataSource.count
    }
    
    // MARK: - Header In Section
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = """
Please, add some ingredients
You can separate ingrients by a \",\"
"""
        label.textAlignment = .center
        label.font = UIFont(name: "Chalkduster", size: 18)
        label.textColor = .white
        label.numberOfLines = 0
        
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return dataSource.count != 0 ? 0 : 100
    }
    
    // MARK: - Cell
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.font = UIFont(name: "Chalkduster", size: 18)
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .clear

        cell.textLabel?.text = "- " + dataSource[indexPath.row].capitalized
        
        return cell
    }
    
    // MARK: - Footer In Section
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 84
    }
    
    // MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataSource.remove(at: indexPath.row)
    }
}

// MARK: - Extension TextField Delegate

extension RecipeSearchController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
