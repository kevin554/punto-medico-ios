import UIKit

class PricesController: UIViewController {

    var pricesArray = [PriceModality(title: "BÁSICO", price: "15 Bs", features: ["2 Fotos", "Por 15 dias de publicación", "en zeta"]), PriceModality(title: "PREMIUM", price: "40 Bs", features: ["Email marketing", "Anuncio destacado"])]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension PricesController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pricesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "priceCell", for: indexPath) as! PriceCell
        
        cell.lbTitle.text = pricesArray[indexPath.row].title
        cell.lbPrice.text = pricesArray[indexPath.row].price
        
        return cell
    }
    
}

extension PricesController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pricesArray[section].features.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "priceFeaturesCell", for: indexPath) as! PriceFeaturesCell
        
        let aSection = pricesArray[indexPath.section]
        
//        let description = aSection.features["subcategories"].arrayValue[indexPath.row]
        return cell
    }
    
}

struct PriceModality {
    
    var title = ""
    var price = ""
    var features = [String]()
    
    init(title: String, price: String, features: [String]) {
        self.title = title
        self.price = price
        self.features = features
    }
    
}
