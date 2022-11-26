//
//  FavoritesViewController.swift
//  Book of recipes
//
//  Created by Yevhenii M on 24.11.2022.
//

import UIKit

class FavoritesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let menuItemTableViewCellIdentifier = "MenuItemTableViewCell"
    var arrayOfMenuItems: [MenuItem] = []
    
    //TODO: If arrayOfMenuItems is empty = show lable that no items
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.arrayOfMenuItems = getFavorites()
        tableView.reloadData()
    }
    
    
    func getFavorites() -> [MenuItem] {
        var result: [MenuItem] = []
        let menuItemIds = UserDefaults().array(forKey: "favorites") as! [Int]
        for id in menuItemIds {
            let currentItem = RealmService().getMenuItemById(id)
            result.append(currentItem)
        }
        
        return result
    }
    
    func registerCells() {
        let menuItemTableCellNib = UINib(nibName: menuItemTableViewCellIdentifier, bundle: nil)
        self.tableView.register(menuItemTableCellNib, forCellReuseIdentifier: menuItemTableViewCellIdentifier)
    }
}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayOfMenuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: menuItemTableViewCellIdentifier, for: indexPath) as? MenuItemTableViewCell {
            let currentRow = indexPath.row
            cell.menuItemTitleLable.text = arrayOfMenuItems[currentRow].title
            cell.restaurantChainLable.text = arrayOfMenuItems[currentRow].restaurantChain
            cell.menuItemImageView.load(stringUrl: arrayOfMenuItems[currentRow].image)
            return cell
        }
        return UITableViewCell()
    }
}
