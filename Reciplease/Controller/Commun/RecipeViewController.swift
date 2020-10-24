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
    private let gradient = CAGradientLayer()
    
    var recipe: Recipe?
    private var recipeIsStored: Bool {
        return coreData.allRecipes.contains(where: {$0.label == recipe?.label})
    }
    
    // MARK: - ViewLife Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        getDirectionsButton.round(background: #colorLiteral(red: 0.268276602, green: 0.5838349462, blue: 0.3624466658, alpha: 1), title: "Get directions", textColor: .white)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupFavoriteTint()
        
    }
    
    // MARK: - Methodes
    
    private func setupFavoriteTint() {
        favoriteButton.tintColor = recipeIsStored ? #colorLiteral(red: 0.268276602, green: 0.5838349462, blue: 0.3624466658, alpha: 1) : #colorLiteral(red: 0.5418370962, green: 0.5419180989, blue: 0.5418193936, alpha: 1)
    }
    
    private func setupView() {
        guard let recipe = recipe else { return }
        if let image = recipe.dataImage {
            recipeImage.image = UIImage(data: image)
        } else if let imageUrl = recipe.image {
            recipeImage.sd_setImage(with: URL(string: imageUrl), completed: nil)
        }
        
        NameLabel.text = recipe.label
        yieldLabel.text = "\(Int(recipe.yield))"
        timeLabel.text = recipe.totalTime.hhmmString
        
        gradient.colors = [UIColor.clear.cgColor, #colorLiteral(red: 0.2145212293, green: 0.2007080019, blue: 0.1960143745, alpha: 1).cgColor]
        gradient.locations = [0, 0.8]
        let gradientFrame = CGRect(x: recipeImage.frame.minX, y: recipeImage.frame.maxY / 2, width: recipeImage.frame.width, height: recipeImage.frame.height / 2)
        gradient.frame = gradientFrame
        recipeImage.layer.addSublayer(gradient)
        
        detailView.layer.cornerRadius = 5
        detailView.layer.borderWidth = 2
        detailView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    private func setupTableView() {
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
    }
    
    // MARK: - Actions
    
    @IBAction func getDirectionsButtonTapped(_ sender: Any) {
        guard let recipe = recipe, let url = URL(string: recipe.url) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func addFavoriteButtonTapped(_ sender: Any) {
        guard let recipe = recipe else { return }
        if recipeIsStored {
            coreData.deleteRecipe(recipe)
            navigationController?.popViewController(animated: true)
        } else {
            guard let image = recipeImage.image?.sd_imageData() else { return }
            coreData.storeRecipe(recipe, image: image)
        }
        setupFavoriteTint()
    }
}

extension RecipeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let recipe = recipe else { return 0 }
        return recipe.ingredientLines.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Ingredients"
        label.font = UIFont(name: "Chalkduster", size: 20)
        label.textColor = .white
        label.backgroundColor = #colorLiteral(red: 0.2145212293, green: 0.2007080019, blue: 0.1960143745, alpha: 1)
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
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
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 84
    }
}
