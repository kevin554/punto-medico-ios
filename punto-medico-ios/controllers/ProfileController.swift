import UIKit

class ProfileController: UIViewController {

    @IBOutlet weak var lbFullName: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var btnLogOut: UIButton!
    @IBOutlet weak var lbPostPublished: UILabel!
    @IBOutlet weak var lbWebsite: UILabel!
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var lbPhone: UILabel!
    @IBOutlet weak var lbCellphone: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnLogOut.imageView?.image = btnLogOut.imageView?.image?.withRenderingMode(.alwaysTemplate)
        btnLogOut.tintColor = Util.colorWithHexString(hexString: "7CB342")
    }
    
    @IBAction func confirmLogOut(_ sender: Any) {
        let alert = UIAlertController(title: "¿Cerrar sesión?", message: "", preferredStyle: .alert)
        
        let actionCancel = UIAlertAction(title: "No", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        })
        
        let actionOk = UIAlertAction(title: "Si", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            self.logOut()
        })
        
        alert.addAction(actionCancel)
        alert.addAction(actionOk)
        
        present(alert, animated: true, completion: nil)
    }
    
    func logOut() {
        if let tabBarController = self.tabBarController {
            let first = self.storyboard?.instantiateViewController(withIdentifier: "LoginController")
            tabBarController.viewControllers![0] = first!
        }
    }
    
}
