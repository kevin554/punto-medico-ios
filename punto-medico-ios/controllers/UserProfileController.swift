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
    }
    
    @IBAction func sendMessage(_ sender: Any) {
    }
    
    @IBAction func makeCall(_ sender: Any) {
    }
    
}
