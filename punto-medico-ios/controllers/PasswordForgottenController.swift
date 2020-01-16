import Alamofire
import SVProgressHUD
import SwiftyJSON
import UIKit

class PasswordForgottenController: UIViewController {
    
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var tfEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgLogo.image = imgLogo.image?.withRenderingMode(.alwaysTemplate)
        imgLogo.tintColor = UIColor.white
        
        /* THE VIEWS HAVE TO MOVE WHEN THE KEYBOARD APPEARS */
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
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
    
    @IBAction func restorePassword(_ sender: Any) {
        let email:String = tfEmail.text!
        
        if email.isEmpty {
            Util.showAlert(title: "El correo no puede estar vacio", message: "")
            return
        }
        
        if !Util.isNetworkConnected() {
            let smallVC = storyboard?.instantiateViewController(withIdentifier: "NoInternetController") as! NoInternetController
            smallVC.transitioningDelegate = (self as! UIViewControllerTransitioningDelegate)
            smallVC.modalPresentationStyle = .custom
            present(smallVC, animated: true, completion: nil)
            
            return
        }
        
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show(withStatus: "Por favor, espere...")
        
        let parameters: Parameters = [
            "email": "\(email)"
        ]
        
//        let headers : HTTPHeaders = ["Authorization": "Bearer \(Util.getToken()!)", "Accept": "application/json"]
        
        Alamofire.request(Api.PASSWORD_FORGOTTEN, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: { response in
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
    
    /* hide the keyboard, if the user touches anything but a textfield */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
