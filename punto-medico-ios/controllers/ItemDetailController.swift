import Cosmos
import UIKit

class ItemDetailController: UIViewController {
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var imgHeader: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var btnUser: UIButton!
    @IBOutlet weak var rating: CosmosView!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var lbSalePrice: UILabel!
    @IBOutlet weak var lbRegularPrice: UILabel!
    @IBOutlet weak var lbDateAdded: UILabel!
    @IBOutlet weak var lbState: UILabel!
    @IBOutlet weak var lbPhone: UILabel!
    @IBOutlet weak var lbHowManySeens: UILabel!
    
    var imageArray = [UIImage(named: "image_shop_9"), UIImage(named: "image_shop_10"), UIImage(named: "image_shop_11"), UIImage(named: "image_shop_12")]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension ItemDetailController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemImagesCell", for: indexPath) as! ItemImagesCell
        
        cell.image.image = imageArray[indexPath.row]
        
        return cell
    }
    
}
