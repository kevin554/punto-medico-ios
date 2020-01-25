import Alamofire
import SVProgressHUD
import SwiftyJSON
import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgLogo.image = imgLogo.image?.withRenderingMode(.alwaysTemplate)
        imgLogo.tintColor = UIColor.white
        
        /* THE VIEWS HAVE TO MOVE WHEN THE KEYBOARD APPEARS */
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @IBAction func validateLogin(_ sender: Any) {
        if 1 == 1 { self.replaceLoginWithProfileScreen(); return; }
        let username:String = tfUsername.text!
        let password:String = tfPassword.text!
        
        if username.isEmpty {
            Util.showAlert(title: "El nombre de usuario no puede estar vacío.", message: "")
            return
        }
        
        if password.isEmpty {
            Util.showAlert(title: "La contraseña no puede estar vacía.", message: "")
            return
        }
        
        if !Util.isNetworkConnected() {
            let smallVC = storyboard?.instantiateViewController(withIdentifier: "NoInternetController") as! NoInternetController
            smallVC.transitioningDelegate = (self as! UIViewControllerTransitioningDelegate)
            smallVC.modalPresentationStyle = .custom
            present(smallVC, animated: true, completion: nil)
            
            return
        }
        
        login(username: username, password: password)
    }
        
    func login(username:String, password:String) {
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show(withStatus: "Por favor, espere...")
        
        let parameters: Parameters = [
            "username": "\(username)",
            "password": "\(password)"
        ]
        
        //        let headers : HTTPHeaders = ["Authorization": "Bearer \(Util.getToken()!)", "Accept": "application/json"]
        
        Alamofire.request(Api.LOGIN, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: { response in
            switch response.result {
            case .success:
                _ = JSON(response.data!)
                self.replaceLoginWithProfileScreen()
                
                break
                
            case .failure:
                break
            }
            
            SVProgressHUD.dismiss()
        })
    }
    
    func replaceLoginWithProfileScreen() {
        if let tabBarController = self.tabBarController {
            let first = self.storyboard?.instantiateViewController(withIdentifier: "ProfileController")
            tabBarController.viewControllers![0] = first!
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardWillChange(notification: Notification) {
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        view.frame.origin.y = -keyboardRect.height
    }
    
    @objc func hideKeyboard(notification: Notification) {
        view.frame.origin.y = 0
    }
    
    /* hide the keyboard, if the user touches anything but a textfield */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
