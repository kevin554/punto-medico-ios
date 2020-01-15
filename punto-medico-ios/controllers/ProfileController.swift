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
        
        let button = UIBarButtonItem(image: UIImage(named: "baseline_add_black_24pt"), style: .plain, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem = button
    }
    
    @objc func addTapped(sender: AnyObject) {
        
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
            let first = self.storyboard?.instantiateViewController(withIdentifier: "LoginController") as! LoginController
            
            let navigationController = UINavigationController(rootViewController: first)
            navigationController.title = "Login"
            
            tabBarController.viewControllers![0] = navigationController
        }
    }
    
}
