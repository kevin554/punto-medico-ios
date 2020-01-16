import Foundation

class Api {
    
    private static let baseUrl = ""
    
    static let LOGIN = "\(baseUrl)/login"
    static let REGISTER = "\(baseUrl)/register"
    static let PASSWORD_FORGOTTEN = "\(baseUrl)/passwordForgotten"
    private static let CATALOG = "\(baseUrl)/catalog" /* ?offset=1&limit=14&search=equipo&itemId=3 */
    private static let USER = "\(baseUrl)/user" /* ?username=rduran */
    static let CATEGORIES = "\(baseUrl)/categories" /* ?category=equipos medicos */
    static let PUBLISH = "\(baseUrl)/publish"
    static let INFO = "\(baseUrl)/info"
    static let PRICES = "\(baseUrl)/prices"
    static let RATE = "\(baseUrl)/rate"
    static let MARK_SEEN = "\(baseUrl)/markSeen"
    
    static func getCatalog() -> String {
        return "\(CATALOG)?offset=0&limit=14"
    }
    
    static func getCatalog(withOffset offset: Int) -> String {
        return "\(CATALOG)?offset=\(offset)&limit=14"
    }
    
    static func getCatalog(withOffset offset: Int, lookingFor searchValue: String) -> String {
        return "\(CATALOG)/?offset=\(offset)&limit=14&search=\(searchValue)"
    }
    
    static func getCatalog(getItem itemId: Int) -> String {
        return "\(CATALOG)/?itemId=\(itemId)"
    }
    
    static func getUser(id: Int) -> String {
        return "\(USER)?id=\(id)"
    }
    
    static func getUser(username: String) -> String {
        return "\(USER)?username=\(username)"
    }
    
    static func getCategories(id: Int) -> String {
        return "\(CATEGORIES)?category=\(id)"
    }
    
}
