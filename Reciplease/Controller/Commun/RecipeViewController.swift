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
    
    @IBOutlet weak var getDirectionsButton: UIButton!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    // MARK: - Properties
    
    private let coreData = CoreDataManager()
    
    var recipe: Recipe?
    private var isStored: Bool {
        return coreData.allRecipesAsStored.contains(where: {$0.name == recipe?.label})
    }
    
    // MARK: - ViewLife Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()

        setupView()
        getDirectionsButton.round(background: #colorLiteral(red: 0.268276602, green: 0.5838349462, blue: 0.3624466658, alpha: 1), title: "Get directions", textColor: .white)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteButton.tintColor = isStored ? #colorLiteral(red: 0.268276602, green: 0.5838349462, blue: 0.3624466658, alpha: 1) : #colorLiteral(red: 0.5418370962, green: 0.5419180989, blue: 0.5418193936, alpha: 1)
    }
    
    // MARK: - Methodes
    
    private func setupView() {
        guard let recipe = recipe else { return }
        if let image = recipe.dataImage {
            recipeImage.image = UIImage(data: image)
        } else {
            recipeImage.sd_setImage(with: URL(string: recipe.image), completed: nil)
        }
        
        NameLabel.text = recipe.label
        yieldLabel.text = "\(Int(recipe.yield))"
        timeLabel.text = recipe.totalTime.hhmmString
        
        recipeImage.createGradient(frame: CGRect(x: recipeImage.frame.minX, y: recipeImage.frame.maxY / 2, width: recipeImage.frame.width, height: recipeImage.frame.height / 2))
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
        if let recipeUrl = recipe?.url {
            guard let url = URL(string: recipeUrl) else {
                return
            }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func addFavoriteButtonTapped(_ sender: Any) {
        guard let recipe = recipe else { return }
        if isStored {
            coreData.deleteRecipe(recipe)
            navigationController?.popViewController(animated: true)
        } else {
            guard let image = recipeImage.image?.sd_imageData() else {
                return
            }
            coreData.storeRecipe(recipe, image: image)
        }
        favoriteButton.tintColor = isStored ? #colorLiteral(red: 0.268276602, green: 0.5838349462, blue: 0.3624466658, alpha: 1) : #colorLiteral(red: 0.5418370962, green: 0.5419180989, blue: 0.5418193936, alpha: 1)
    }
}

extension RecipeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let recipe = recipe else { return 0}
        return recipe.ingredientLines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        if let ingredients = recipe?.ingredientLines {
            cell.textLabel?.text = "- \(ingredients[indexPath.row])"
        }
        
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont(name: "Chalkduster", size: 17)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}
