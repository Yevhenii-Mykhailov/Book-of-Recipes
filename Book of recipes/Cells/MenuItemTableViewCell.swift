//
//  ReceipTableViewCell.swift
//  Book of recipes
//
//  Created by Yevhenii M on 22.11.2022.
//

import UIKit

class MenuItemTableViewCell: UITableViewCell {
    @IBOutlet weak var mainCellView: UIView!
    @IBOutlet weak var menuItemImageView: UIImageView!
    @IBOutlet weak var menuItemTitleLable: UILabel!
    @IBOutlet weak var restaurantChainLable: UILabel!
    @IBOutlet weak var backgrounCellView: UIView!
    @IBOutlet weak var favotiresButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func setupCell() {
        menuItemImageView.layer.cornerRadius = 10
        backgrounCellView.layer.cornerRadius = 10
    }
    
    var favButtonPressed : (() -> ()) = {}
    @IBAction func addToFavorites(_ sender: Any) {
        favButtonPressed()
    }
}
