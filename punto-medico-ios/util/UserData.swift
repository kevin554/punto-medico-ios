import Foundation
import SwiftyJSON

class UserData {

    private static let PROFILE = "profile"
    
    class func getProfileData() -> JSON? {
        let data = UserDefaults.standard.string(forKey: PROFILE)
        
        if data == nil {
            return []
        }
        
        return JSON.init(parseJSON: data!)
    }
    
    class func setProfileData(profileData:Any?) {
        if profileData == nil {
            UserDefaults.standard.removeObject(forKey: PROFILE)
            return
        }
        
        UserDefaults.standard.set(profileData, forKey: PROFILE)
    }
    
}
