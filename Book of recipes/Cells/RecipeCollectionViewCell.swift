//
//  ReceipCollectionViewCell.swift
//  Book of recipes
//
//  Created by Yevhenii M on 22.11.2022.
//

import UIKit

class RecipeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var backgroundCellView: UIView!
    @IBOutlet weak var favoritesButton: UIButton!
    @IBOutlet weak var readyInMinutesLable: UILabel!
    @IBOutlet weak var recipeTitleLable: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCell()
    }

    func setupCell() {
        backgroundCellView.layer.cornerRadius = 10
        recipeImageView.layer.cornerRadius = 10
    }
}
