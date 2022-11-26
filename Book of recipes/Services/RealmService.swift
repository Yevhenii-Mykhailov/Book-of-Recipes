//
//  RealmService.swift
//  Book of recipes
//
//  Created by Yevhenii M on 23.11.2022.
//

import Foundation
import RealmSwift

class RealmService {
    private let realm = try! Realm()
    
    func getMenuItemById(_ menuItemId: Int) -> MenuItem {
        var result = MenuItem()
        let realmObject = realm.objects(MenuItemsModel.self)
        
        if let realmQuery = realmObject.first?.menuItems {
            for item in realmQuery {
                if item.id == menuItemId {
                    result = item
                }
            }
        }
        
        return result
    }
    
    //TODO: Need to make all functions with generic type
    
    //MARK: Work with Realm for MenuItems
    func addMenuItemsToRealm(_ menuItemsResults: MenuItemsModel) {
        let result = menuItemsResults
        
        try! realm.write({
            realm.add(result)
        })
    }
    func getAllMenuItemsFromRealm() -> [MenuItemsModel] {
        let realmObject = realm.objects(MenuItemsModel.self)
        var result: [MenuItemsModel] = []
        
        for (_ ,item) in realmObject.enumerated() {
            result.append(item)
        }
        
        return result
    }
    func getArrayOfMenuItemsFromFirstRealmObject() -> [MenuItem] {
        guard let firstRealmObject = self.getAllMenuItemsFromRealm().first else { return [] }
        var recipeArray: [MenuItem] = []
        
        for item in firstRealmObject.menuItems {
            recipeArray.append(item)
        }
        
        return recipeArray
    }
    
    //MARK: Work with Realm for Recipes
    func getArrayOfRecipesFromFirstRealmObject() -> [RecipeRealm] {
        guard let firstRealmObject = self.getAllRecipesFromRealm().first else { return [] }
        var recipeArray: [RecipeRealm] = []
        
        for item in firstRealmObject.recipes {
            recipeArray.append(item)
        }
        
        return recipeArray
    }
    func getAllRecipesFromRealm() -> [RecipesModelRealm] {
        let realmObject = realm.objects(RecipesModelRealm.self)
        var result: [RecipesModelRealm] = []
        for (_ ,item) in realmObject.enumerated() {
            result.append(item)
        }
        
        return result
    }
    func addRecipesToRealm(_ recipesResults: RecipesModelRealm) {
        let result = recipesResults
        
        try! realm.write({
            realm.add(result)
        })
    }


}
