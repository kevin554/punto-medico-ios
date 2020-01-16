import Alamofire
import SVProgressHUD
import SwiftyJSON
import UIKit

class UserProfileController: UIViewController {

    @IBOutlet weak var lbFullName: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var btnMessage: UIButton!
    @IBOutlet weak var btnCall: UIButton!
    @IBOutlet weak var lbPosts: UILabel!
    @IBOutlet weak var lbWebsite: UILabel!
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var lbPhone: UILabel!
    @IBOutlet weak var lbCellphone: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnMessage.imageView?.image = btnMessage.imageView?.image?.withRenderingMode(.alwaysTemplate)
        btnCall.imageView?.image = btnCall.imageView?.image?.withRenderingMode(.alwaysTemplate)

        btnMessage.tintColor = Util.colorWithHexString(hexString: "7CB342")
        btnCall.tintColor = Util.colorWithHexString(hexString: "7CB342")
        
        fetchProfile()
    }
    
    func fetchProfile() {
        if !Util.isNetworkConnected() {
            Util.showAlert(title: "Parece que no hay internet.", message: "")
            return
        }
        
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show(withStatus: "Cargando perfil...")
        
        Alamofire.request(Api.getUser(username: "rduran")).responseJSON(completionHandler: { response in
            switch response.result {
            case .success:
                _ = JSON(response.data!)
                break
                
            case .failure:
                break
            }
            
            SVProgressHUD.dismiss()
        })
    }
    
    @IBAction func sendMessage(_ sender: Any) {
    }
    
    @IBAction func makeCall(_ sender: Any) {
    }
    
}
