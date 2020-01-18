//import RealmSwift
import SwiftyJSON

class Item {//}: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var description = ""
    @objc dynamic var salePrice = ""
    @objc dynamic var regularPrice = ""
    @objc dynamic var dateAdded = 0
    @objc dynamic var state = ""
    @objc dynamic var cellphone = ""
    @objc dynamic var address = ""
    @objc dynamic var seens = 0
    @objc dynamic var rating = 0.0
    @objc dynamic var userId = 0
    @objc dynamic var userFullName = ""
    @objc dynamic var type = ""
    @objc dynamic var category = ""
    @objc dynamic var subcategory = ""
    @objc dynamic var videoUrl = ""
//    let comments = List<Comment>()
//    let images = List<String>()
//    let tags = List<String>()
//    @objc dynamic var user: User?
    
    convenience init(fromJSON json: JSON) {
        self.init()
        
        self.title = json["title"].stringValue
        self.description = json["description"].stringValue
        self.salePrice = json["salePrice"].stringValue
        self.regularPrice = json["regularPrice"].stringValue
        self.dateAdded = json["dateAdded"].intValue
        self.state = json["state"].stringValue
        self.cellphone = json["cellphone"].stringValue
        self.address = json["address"].stringValue
        self.seens = json["seens"].intValue
        self.rating = json["rating"].doubleValue
        self.userId = json["userId"].intValue
        self.userFullName = json["userFullName"].stringValue
        self.type = json["type"].stringValue
        self.category = json["category"].stringValue
        self.subcategory = json["subcategory"].stringValue
        self.videoUrl = json["videoUrl"].stringValue
    }
    
}

class Category {//}: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var name = ""
//    let subcategories = List<Subcategory>()
    
    convenience init(fromJSON json: JSON) {
        self.init()
        
        self.name = json["name"].stringValue
    }
    
}

class Subcategory {//}: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    
    convenience init(fromJSON json: JSON) {
        self.init()
        
        self.name = json["name"].stringValue
    }
    
}

class Comment {//}: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var username = ""
    @objc dynamic var fullName = ""
    @objc dynamic var website = ""
    @objc dynamic var comment = ""
    @objc dynamic var date = 0
//    @objc dynamic var user: User?
    
    convenience init(fromJSON json: JSON) {
        self.init()
        
        self.username = json["username"].stringValue
        self.fullName = json["fullName"].stringValue
        self.website = json["website"].stringValue
        self.comment = json["comment"].stringValue
        self.date = json["date"].intValue
    }
    
}

class User {//}: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var username = ""
    @objc dynamic var name = ""
    @objc dynamic var fullName = ""
    @objc dynamic var postsPublished = 0
    @objc dynamic var website = ""
    @objc dynamic var email = ""
    @objc dynamic var phone = ""
    @objc dynamic var cellphone = ""
    @objc dynamic var image = ""
//    let posts = List<Item>()
    
    convenience init(fromJSON json: JSON) {
        self.init()
        
        self.username = json["username"].stringValue
        self.name = json["name"].stringValue
        self.fullName = json["fullName"].stringValue
        self.postsPublished = json["postsPublished"].intValue
        self.website = json["website"].stringValue
        self.email = json["email"].stringValue
        self.phone = json["phone"].stringValue
        self.cellphone = json["cellphone"].stringValue
        self.image = json["image"].stringValue
    }
    
}

class Price {//}: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var price = ""
//    let features = List<String>()
    
    convenience init(fromJSON json: JSON) {
        self.init()
        
        self.title = json["title"].stringValue
        self.price = json["price"].stringValue
    }
    
}
