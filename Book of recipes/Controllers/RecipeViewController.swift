//
//  RecipViewController.swift
//  Book of recipes
//
//  Created by Yevhenii M on 22.11.2022.
//

import UIKit
import Alamofire

class RecipeViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    let recipeTableViewCellIdentifier = "MenuItemTableViewCell"
    let recipeCollectionViewCellIdentifier = "RecipeCollectionViewCell"
    var arrayOfRecipesCollection: [RecipeRealm] = []
    var arrayOfMenuItems: [MenuItem] = []
    
    var recipesModelRealm = RecipesModelRealm()
    var menuItemModel = MenuItemsModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        
        //TODO: First start of app did not call request (or did not store and get items from Realm)
        AF.request("https://api.spoonacular.com/recipes/random?number=5&apiKey=01e98ad13e1b4f179f0761ad99eb6449").responseDecodable(of: RecipesModelRealm.self) { response in
            guard let result = response.value else {
                print(response.error ?? "")
                return
            }
            self.recipesModelRealm = result
            RealmService().addRecipesToRealm(self.recipesModelRealm)

            self.collectionView.reloadData()
        }
        
        
        AF.request("https://api.spoonacular.com/food/menuItems/search?apiKey=01e98ad13e1b4f179f0761ad99eb6449&query=burger&number=5").responseDecodable(of: MenuItemsModel.self) { response in
            guard let result = response.value else {
                print(response.error ?? "")
                return
            }
            self.menuItemModel = result
            RealmService().addMenuItemsToRealm(self.menuItemModel)
            self.tableView.reloadData()
        }
        
        self.arrayOfRecipesCollection = RealmService().getArrayOfRecipesFromFirstRealmObject()
        self.arrayOfMenuItems = RealmService().getArrayOfMenuItemsFromFirstRealmObject()
    }
    
    
    func registerCells() {
        let receipCollectionCellNib = UINib(nibName: recipeCollectionViewCellIdentifier, bundle: nil)
        self.collectionView.register(receipCollectionCellNib, forCellWithReuseIdentifier: recipeCollectionViewCellIdentifier)
        
        let receipTableCellNib = UINib(nibName: recipeTableViewCellIdentifier, bundle: nil)
        self.tableView.register(receipTableCellNib, forCellReuseIdentifier: recipeTableViewCellIdentifier)
    }
}

extension RecipeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrayOfRecipesCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recipeCollectionViewCellIdentifier, for: indexPath) as? RecipeCollectionViewCell {
            let currentCellRow = indexPath.row
            cell.recipeTitleLable.text = arrayOfRecipesCollection[currentCellRow].title
            cell.readyInMinutesLable.text = String(arrayOfRecipesCollection[currentCellRow].readyInMinutes)
            cell.recipeImageView.load(stringUrl: arrayOfRecipesCollection[currentCellRow].image)
            
            return cell
        }
        return UICollectionViewCell()
    }
}

extension RecipeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayOfMenuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var rowsThatAreChecked = UserDefaults.standard.array(forKey: "favorites") as? [Int] ?? [Int]()
        if let cell = tableView.dequeueReusableCell(withIdentifier: recipeTableViewCellIdentifier, for: indexPath) as? MenuItemTableViewCell {
            let currentRow = indexPath.row
            cell.menuItemTitleLable.text = arrayOfMenuItems[currentRow].title
            cell.restaurantChainLable.text = arrayOfMenuItems[currentRow].restaurantChain
            cell.menuItemImageView.load(stringUrl: arrayOfMenuItems[currentRow].image)
            
            if rowsThatAreChecked.contains(arrayOfMenuItems[currentRow].id) {
                cell.favotiresButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            } else {
                cell.favotiresButton.setImage(UIImage(systemName: "heart"), for: .normal)
            }
            
            cell.favButtonPressed = { [ weak self ] in
                guard let self = self else { return }
                if rowsThatAreChecked.contains(self.arrayOfMenuItems[currentRow].id) {
                    let removeIdx = rowsThatAreChecked.lastIndex(where: {$0 == self.arrayOfMenuItems[currentRow].id})
                    rowsThatAreChecked.remove(at: removeIdx!)
                    
                    cell.favotiresButton.setImage(UIImage(systemName: "heart"), for: .normal)
                } else {
                    cell.favotiresButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                    rowsThatAreChecked.append(self.arrayOfMenuItems[currentRow].id)
                }
                UserDefaults.standard.set(rowsThatAreChecked, forKey: "favorites")
                self.tableView.reloadData()
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
}
