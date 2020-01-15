import UIKit

class CatalogController: UIViewController {

    @IBOutlet weak var searchbar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchbar.backgroundImage = UIImage()
        
        // TODO: if the user is logged
//        if let tabBarController = self.tabBarController {
//            let first = self.storyboard?.instantiateViewController(withIdentifier: "ProfileController") as! ProfileController
//            tabBarController.viewControllers![0] = first
//            tabBarController.viewControllers![0].title = "Mi perfil"
//        }
    }

}

extension CatalogController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "catalogCell", for: indexPath) as! CatalogCell
        
//        cell.image.image = imageArray[indexPath.row]
        
        /* MyTapOnSubjectGesture */
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleCardTap(recognizer:)))
        cell.contentView.addGestureRecognizer(tapGestureRecognizer)
//        tapGestureRecognizer.obj = aSection.subjects[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 10
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize / 2, height: 220)
    }
    
    @objc
    func handleCardTap(recognizer: UITapGestureRecognizer) {
        performSegue(withIdentifier: "ItemDetail", sender: nil)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        segue.destination.transitioningDelegate = self
//        segue.destination.modalPresentationStyle = .custom
//
//        let vc = segue.destination as! SubjectAcademicRecordController
//        vc.subject = sender as! Subject
//    }
    
}

//class MyTapOnSubjectGesture: UITapGestureRecognizer {
//
//    var obj = Subject()
//
//}
