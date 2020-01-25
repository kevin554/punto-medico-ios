import UIKit

class ImageDetailController: UIViewController {

    @IBOutlet weak var theImage: UIImageView!
    var image:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let imageToLoad = image {
            theImage.image = UIImage(named: imageToLoad)
        }
    }
    
}
