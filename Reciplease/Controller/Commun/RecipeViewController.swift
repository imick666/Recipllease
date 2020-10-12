//
//  RecipeViewController.swift
//  Reciplease
//
//  Created by mickael ruzel on 11/10/2020.
//

import UIKit

class RecipeViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var NameLabel: UILabel!
    
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var yieldLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    // MARK: - Properties
    
    var recipe: Recipe?
    
    // MARK: - ViewLife Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()

        setupView()
    }
    
    // MARK: - Methodes
    
    private func setupView() {
        guard let recipe = recipe else {
            return
        }
        
        recipeImage.sd_setImage(with: URL(string: recipe.recipe.image), completed: nil)
        recipeImage.createGradient(frame: CGRect(x: recipeImage.frame.minX, y: recipeImage.frame.maxY / 2, width: recipeImage.frame.width, height: recipeImage.frame.height / 2))
        NameLabel.text = recipe.recipe.label
        yieldLabel.text = "\(Int(recipe.recipe.yield))"
        timeLabel.text = recipe.recipe.totalTime.hhmmString
        
        detailView.layer.cornerRadius = 5
        detailView.layer.borderWidth = 2
        detailView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    private func setupTableView() {
        // Create TableView Header
        var headerView: UIView {
            let label = UILabel(frame: CGRect(x: 8, y: 0, width: 150, height: 44))
            label.text = "Ingredients"
            label.font = UIFont(name: "Chalkduster", size: 22)
            label.textColor = .white
            label.backgroundColor = .clear
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
            view.backgroundColor = .clear
            view.addSubview(label)
            
            return view
        }
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 84))
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
    }
    
    // MARK: - Actions
    
    @IBAction func getDirectionsButtonTapped(_ sender: Any) {
    }
    
    @IBAction func addFavoriteButtonTapped(_ sender: Any) {
    }
    
}

extension RecipeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let ingredients = recipe?.recipe.ingredientLines else {
            return 0
        }
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        guard let ingredients = recipe?.recipe.ingredientLines else {
            return UITableViewCell()
        }
        
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont(name: "Chalkduster", size: 17)
        cell.textLabel?.text = "- \(ingredients[indexPath.row])"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    
    
}
