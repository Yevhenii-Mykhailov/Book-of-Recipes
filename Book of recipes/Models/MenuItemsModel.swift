import Foundation
import RealmSwift

class MenuItemsModel: Object, Codable {
    @Persisted var type: String
    @Persisted var menuItems: List<MenuItem>
    var offset: Int
    @Persisted var number: Int
    @Persisted var totalMenuItems: Int
//    let processingTimeMS: Double
    var expires: Int
    var isStale: Bool
}

class MenuItem: EmbeddedObject, Codable {
    @Persisted var id: Int
    @Persisted var title: String
    @Persisted var image: String
    let imageType: String
    @Persisted var restaurantChain: String
    let servingSize, readableServingSize: String?
    let servings: Servings?
}

class Servings: Codable {
    let number: Int
    let size: Int?
    let unit: String?
}
