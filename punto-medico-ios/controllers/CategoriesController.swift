import Alamofire
import SVProgressHUD
import SwiftyJSON
import UIKit

class CategoriesController: UIViewController {
    
    @IBOutlet weak var categoriesTableView: UITableView!
    var list:[JSON] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationController?.navigationBar.tintColor = .white
        categoriesTableView.tableFooterView = UIView(frame: CGRect.zero)
        
//        if let tabBarController = self.tabBarController {
//            let first = self.storyboard?.instantiateViewController(withIdentifier: "LoginController") as! LoginController
//            tabBarController.viewControllers![0] = first
//        }
//        fetchCategories()
    }
    
    func fetchCategories() -> Void {
        if !Util.isNetworkConnected() {
            return
        }
        
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show(withStatus: "Obteniendo catálogo")
        
        Alamofire.request("https://jsonmock.com/api/get/KqFinHVQ6WgX0PRnc8Uglg8p66zGN9Lz").responseJSON(completionHandler: { response in
            switch response.result {
            case .success:
                let apiResponse = JSON(response.data!)
                
                self.list = apiResponse.arrayValue
                self.categoriesTableView.reloadData()
                
                break
                
            case .failure:
                break
            }
            
            SVProgressHUD.dismiss()
        })
    }
    
}

extension CategoriesController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let aSection = list[section]
        return aSection["name"].stringValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let aSection = list[section]
        return aSection["subcategories"].arrayValue.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catalogCell", for: indexPath) as! CategoriesCell
        
        let aSection = list[indexPath.section]

        let subcategory = aSection["subcategories"].arrayValue[indexPath.row]
        let name = subcategory["name"].string

        cell.lbName.text = name
        
//        let tapGestureRecognizer = MyTapOnSubjectGesture(target: self, action: #selector(handleCardTap(recognizer:)))
//        cell.contentView.addGestureRecognizer(tapGestureRecognizer)
//        tapGestureRecognizer.obj = aSection.subjects[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(integerLiteral: 48)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("CatalogHeaderCell", owner: self, options: nil)?.first as! CategoriesHeaderCell
        
        let category = list[section]
        headerView.lbName.text = category["name"].stringValue
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = Bundle.main.loadNibNamed("CatalogFooterCell", owner: self, options: nil)?.first as! CategoriesFooterCell
        
        _ = list[section]
        
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(integerLiteral: 64)
    }
    
//    @objc
//    func handleCardTap(recognizer: MyTapOnSubjectGesture) {
//        performSegue(withIdentifier: "SubjectDetail", sender: recognizer.obj)
//    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        segue.destination.transitioningDelegate = self
//        segue.destination.modalPresentationStyle = .custom
//
//        let vc = segue.destination as! SubjectAcademicRecordController
//        vc.subject = sender as! Subject
//    }
    
}
