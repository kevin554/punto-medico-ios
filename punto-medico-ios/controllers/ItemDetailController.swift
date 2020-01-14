import UIKit

class ItemDetailController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    var imageArray = [UIImage(named: "image_shop_9"), UIImage(named: "image_shop_10"), UIImage(named: "image_shop_11"), UIImage(named: "image_shop_12")]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemImagesCell", for: indexPath) as! ItemImagesCell
        
        cell.image.image = imageArray[indexPath.row]
        
        return cell
    }
    
}
