//
//  RecipesTableViewCell.swift
//  Reciplease
//
//  Created by mickael ruzel on 08/10/2020.
//

import UIKit
import SDWebImage

class RecipesTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var yieldLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var bottomLayer: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        detailView.layer.cornerRadius = 5
        detailView.layer.borderColor = UIColor.white.cgColor
        detailView.layer.borderWidth = 2
        backgroundImage.createGradient(frame: bottomLayer.frame)
    }
    
    let network = NetworkServices()
    
    var recipe: Recipe? {
        didSet {
            setupCell()
        }
    }
    
    private func setupCell() {
        guard let recipe = recipe else {
            return
        }
        
        yieldLabel.text = "\(recipe.recipe.yield)"
        timeLabel.text = "\(recipe.recipe.totalTime)"
        nameLabel.text = recipe.recipe.label
        backgroundImage.sd_setImage(with: URL(string: recipe.recipe.image), completed: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
