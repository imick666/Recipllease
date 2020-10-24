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
    
    private var gradient = CAGradientLayer()
    
    // MARK: - Override
    
    override func awakeFromNib() {
        super.awakeFromNib()
        detailView.layer.cornerRadius = 5
        detailView.layer.borderWidth = 2
        detailView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        gradient.colors = [UIColor.clear.cgColor, #colorLiteral(red: 0.2145212293, green: 0.2007080019, blue: 0.1960143745, alpha: 1).cgColor]
        gradient.locations = [0, 0.8]
        backgroundImage.layer.addSublayer(gradient)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let gradientFrame = CGRect(x: backgroundImage.frame.minX, y: backgroundImage.frame.maxY / 2, width: backgroundImage.frame.width, height: backgroundImage.frame.height / 2)
        gradient.frame = gradientFrame
    }
    
    // MARK: - Methodes
    
    private func setupCell() {
        guard let recipe = recipe else {
            return
        }
        
        if let image = recipe.dataImage {
            backgroundImage.image = UIImage(data: image)
        } else if let imageUrl = recipe.image {
            backgroundImage.sd_setImage(with: URL(string: imageUrl), completed: nil)
        }
        nameLabel.text = recipe.label
        yieldLabel.text = "\(Int(recipe.yield))"
        timeLabel.text = recipe.totalTime.hhmmString
        ingredientsLabel.text = recipe.ingredientLines.joined(separator: ", ")
    }
}
