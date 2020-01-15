import UIKit

class PriceFeaturesCell: UITableViewCell {

    @IBOutlet weak var checkbox: UIImageView!
    @IBOutlet weak var lbDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        checkbox.image = checkbox.image?.withRenderingMode(.alwaysTemplate)
        checkbox.tintColor = Util.colorWithHexString(hexString: "D81B60")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
