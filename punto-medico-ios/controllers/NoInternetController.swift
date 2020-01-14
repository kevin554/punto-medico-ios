import UIKit

class NoInternetController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
    }
    
    @IBAction func bntOk(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
