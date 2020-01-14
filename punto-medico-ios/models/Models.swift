import SwiftyJSON

class Category {
    
    var name = ""
//    var subcategories = List<Subcategory>()
    
    convenience init(fromJSON json: JSON) {
        self.init()
        self.name = json["name"].stringValue
    }
    
}

class Subcategory {//}: Object {
    
//    @objc dynamic var SSIGLACODIGO = ""
    var name = ""
    
    convenience init(fromJSON json: JSON) {
        self.init()
        self.name = json["name"].stringValue
    }
    
}
