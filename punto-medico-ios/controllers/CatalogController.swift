import Alamofire
import SwiftyJSON
import SVProgressHUD
import UIKit

class CatalogController: UIViewController {

    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(confirmLoadMore), for: .valueChanged)
        
        return refreshControl
    }()
    
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var catalogCollectionView: UICollectionView!
    var fetchingMore = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchbar.backgroundImage = UIImage()
        
        catalogCollectionView.refreshControl = refresher
        
        if !UserData.getProfileData()!.isEmpty {
            if let tabBarController = self.tabBarController {
                let first = self.storyboard?.instantiateViewController(withIdentifier: "ProfileController") as! ProfileController
                
                tabBarController.viewControllers![0] = first
                tabBarController.viewControllers![0].title = "Mi perfil"
            }
        }

        fetchCatalog()
    }
    
    func fetchCatalog() {
        if !Util.isNetworkConnected() {
            Util.showAlert(title: "Parece que no hay internet.", message: "")
            return
        }
        
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show(withStatus: "Obteniendo catálogo...")
        
        Alamofire.request(Api.getCatalog()).responseJSON(completionHandler: { response in
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
    
    @objc
    func confirmLoadMore() {
        let alert = UIAlertController(title: "¿Desea actualizar el catálogo?", message: "", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            
            if !Util.isNetworkConnected() {
                Util.showAlert(title: "Parece que no hay internet.", message: "")
                self.refresher.endRefreshing()
                
                return
            }
            
            self.loadMore()
        })
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            self.refresher.endRefreshing()
        })
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func loadMore() {
        self.refresher.endRefreshing()
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
//        print("offsetY: \(offsetY) | contentHeight: \(contentHeight)")
        
        if offsetY > contentHeight - scrollView.frame.height { // * 4
            if !fetchingMore {
                fetchingMore = true
//                print("begin batch fetch!")
            }
            
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        segue.destination.transitioningDelegate = self
//        segue.destination.modalPresentationStyle = .custom
//
//        let vc = segue.destination as! SubjectAcademicRecordController
//        vc.subject = sender as! Subject
//    }
    
}

extension CatalogController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        print("search for \(searchText)")
    }
    
}

//class MyTapOnSubjectGesture: UITapGestureRecognizer {
//
//    var obj = Subject()
//
//}
