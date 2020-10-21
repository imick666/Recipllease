//
//  RecipesListTableViewCell.swift
//  Reciplease
//
//  Created by mickael ruzel on 11/10/2020.
//

import UIKit
import SDWebImage

class RecipesListTableViewCell: UITableViewCell {
    
    // MARK: - Outlets

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var yieldLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    
    // MARK: - Properties
    
    var recipe: Recipe? {
        didSet {
            setupCell()
        }
    }
    
    var storedRecipe: StoredRecipe? {
        didSet {
            setupCellFromStored()
        }
    }
    
    // MARK: - Override
    
    override func awakeFromNib() {
        super.awakeFromNib()
        detailView.layer.cornerRadius = 5
        detailView.layer.borderWidth = 2
        detailView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let gradientFrame = CGRect(x: self.frame.minX, y: self.frame.maxY / 2, width: self.bounds.width, height: self.bounds.height / 2)
        backgroundImage.createGradient(frame: gradientFrame)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Methodes
    
    private func setupCell() {
        guard let recipe = recipe else {
            return
        }
        backgroundImage.sd_setImage(with: URL(string: recipe.image), completed: nil)
        nameLabel.text = recipe.label
        yieldLabel.text = "\(Int(recipe.yield))"
        timeLabel.text = recipe.totalTime.hhmmString
        ingredientsLabel.text = recipe.ingredientLines.joined(separator: ", ")
    }
    
    private func setupCellFromStored() {
        guard let recipe = storedRecipe else {
            return
        }
        backgroundImage.image = UIImage(data: recipe.image!)
        nameLabel.text = recipe.name
        yieldLabel.text = "\(Int(recipe.yield))"
        timeLabel.text = recipe.totalTime.hhmmString
    }
    
}
