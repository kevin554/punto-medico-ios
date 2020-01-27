import Alamofire
import DLRadioButton
import SVProgressHUD
import SwiftyJSON
import UIKit

class PublishNewItemController: UIViewController {

    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var descTF: UITextField!
    @IBOutlet weak var tagsTF: UITextField!
    @IBOutlet weak var salePriceTF: UITextField!
    @IBOutlet weak var regularPriceTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var newRB: DLRadioButton!
    @IBOutlet weak var usedRB: DLRadioButton!
    @IBOutlet weak var selectCategoryBtn: UIButton!
    @IBOutlet weak var selectSubcategoryBtn: UIButton!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    var categories = ["Equipos medicos", "Equipos de laboratorio", "Equipos de odontologia", "Equipos de estetica", "Insumos medicos y de laboratorio", "Insumos de odontologia", "Respuestas y accesorios", "Servicios y otros"]
    var selectedCategory = ""
    var imageArray = [UIImage]() /* 4 max images */
    var selectingImageAtPos = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* THE VIEWS HAVE TO MOVE WHEN THE KEYBOARD APPEARS */
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @IBAction func validateForm(_ sender: Any) {
        let IMAGE_SIZE = 300000 // max 300kb
        let BASE_64_JPEG = "data:image/jpeg;base64,"
        let title = titleTF.text!
        let desc = descTF.text!
        let tags = tagsTF.text!
        let salePrice = salePriceTF.text!
        let regularPrice = regularPriceTF.text!
        let phone = phoneTF.text!
        let address = addressTF.text!
        let state = newRB.isSelected ? "Nuevo" : (usedRB.isSelected ? "Usado" : "")
        var imagesB64 = [String]()
        
        if title.isEmpty {
            Util.showAlert(title: "Debe colocar un título.", message: "")
            return
        }

        if salePrice.isEmpty {
            Util.showAlert(title: "Debe colocar un precio de venta.", message: "")
            return
        }

        if phone.isEmpty {
            Util.showAlert(title: "Debe colocar un teléfono de referencia.", message: "")
            return
        }

        if address.isEmpty {
            Util.showAlert(title: "Debe colocar su ciudad.", message: "")
            return
        }

        if state.isEmpty {
            Util.showAlert(title: "Debe especificar el estado del equipo.", message: "")
            return
        }

        if selectedCategory.isEmpty {
            Util.showAlert(title: "Debe seleccionar una categoria.", message: "")
            return
        }
        
        if imageArray[safe: 0] != nil {
//            let imageData = imageArray[1].pngData()
//            firstImage = imageData!.base64EncodedString(options: .lineLength64Characters)
            imagesB64.append(BASE_64_JPEG + imageArray[0].resizeByByte(maxByte: IMAGE_SIZE))
        }
        
        if imageArray[safe: 1] != nil {
            imagesB64.append(BASE_64_JPEG + imageArray[1].resizeByByte(maxByte: IMAGE_SIZE))
        }
        
        if imageArray[safe: 2] != nil {
            imagesB64.append(BASE_64_JPEG + imageArray[2].resizeByByte(maxByte: IMAGE_SIZE))
        }
        
        if imageArray[safe: 3] != nil {
            imagesB64.append(BASE_64_JPEG + imageArray[3].resizeByByte(maxByte: IMAGE_SIZE))
        }
        
        submitForm(title: title, desc: desc, tags: tags, salePrice: salePrice, regularPrice: regularPrice, phone: phone, address: address, state: state, images: imagesB64, category: selectedCategory, subcategory: "")
    }
    
    func submitForm(title:String, desc:String, tags:String, salePrice:String, regularPrice:String, phone:String, address:String, state:String, images:[String], category: String, subcategory: String) {
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show(withStatus: "Por favor, espere...")
        
        let parameters: Parameters = [
            "title": "\(title)",
            "desc": "\(desc)",
            "tags": "\(tags)",
            "salePrice": "\(salePrice)",
            "regularPrice": "\(regularPrice)",
            "cellphone": "\(phone)",
            "address": "\(address)",
            "state": "\(state)",
            "images": "\(images)",
            "dateAdded": "",
            "userId": 0,
            "userFullName": "",
            "category": 0,
            "subcategory": 0
        ]
        
        //        let headers : HTTPHeaders = ["Authorization": "Bearer \(Util.getToken()!)", "Accept": "application/json"]
        
        Alamofire.request(Api.PUBLISH, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON(completionHandler: { response in
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
    
    @IBAction func showSelectCategoryDialog(_ sender: Any) {
        let alert = UIAlertController(title: "Categorías", message: "", preferredStyle: .alert)
        
        categories.forEach { (category) in
            alert.addAction(UIAlertAction(title: category, style: .default, handler: { (UIAlertAction) in
                self.selectCategoryBtn.setTitle(category, for: .normal)
                self.selectCategoryBtn.titleLabel?.textColor = .black
                self.selectCategoryBtn.setTitleColor(.black, for: .normal)

                self.selectedCategory = category
            }))
        }
        
        self.present(alert, animated: true, completion: {
            alert.view.superview?.isUserInteractionEnabled = true
            alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
        })
    }
    
    @IBAction func showSelectSubcategoryDialog(_ sender: Any) {
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
    
    /* hide the keyboard, if the user touches anything but a textfield */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc private func alertControllerBackgroundTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension PublishNewItemController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            if imageArray[safe: selectingImageAtPos] != nil {
                imageArray[selectingImageAtPos] = image
            } else {
                imageArray.insert(image, at: selectingImageAtPos)
            }
            
            imagesCollectionView.reloadData()
        } else {
            // Error message
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension PublishNewItemController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemImagesPublishedCell", for: indexPath) as! ItemImagesCell
        
        if let image = imageArray[safe: indexPath.row] {
            cell.image.image = image
        } else {
            cell.image.image = UIImage(named: "baseline_add_black_24pt")
        }
        
        let tapRecognizer = MyTapOnImageGesture(target: self, action: #selector(handleTap(recognizer:)))
        tapRecognizer.pos = indexPath.row
        cell.contentView.addGestureRecognizer(tapRecognizer)
        
        return cell
    }
    
    @objc
    func handleTap(recognizer:MyTapOnImageGesture) {
        if imageArray[safe: recognizer.pos] != nil {
            showImageActionsDialog(pos: recognizer.pos)
            return
        }
        
        showImagePicker(pos: recognizer.pos)
    }
    
    func showImageActionsDialog(pos:Int) {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        
        let actionRemove = UIAlertAction(title: "Quitar", style: .default, handler: { (action) in
            self.imageArray.remove(at: pos)
            self.imagesCollectionView.reloadData()
        })
        
        let actionReplace = UIAlertAction(title: "Cambiar", style: .default, handler: { (action) in
            self.showImagePicker(pos: pos)
        })
        
        alert.addAction(actionRemove)
        alert.addAction(actionReplace)
        
        present(alert, animated: true, completion: {
            alert.view.superview?.isUserInteractionEnabled = true
            alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
        })
    }
    
    func showImagePicker(pos:Int) {
        selectingImageAtPos = pos
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        
        self.present(imagePicker, animated: true)
    }
    
}

extension Collection {
    
    /* Returns the element at the specified index if it is within bounds, otherwise nil. */
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
}

extension UIImage {
    
//    func resizeByByte(maxByte: Int, completion: @escaping (Data) -> Void) {
//        var compressQuality: CGFloat = 1
//        var imageData = Data()
//        var imageByte = jpegData(compressionQuality: 1)?.count
//
//        while imageByte! > maxByte {
//            imageData = jpegData(compressionQuality: compressQuality)!
//            imageByte = jpegData(compressionQuality: compressQuality)?.count
//            compressQuality -= 0.1
//        }
//
//        if maxByte > imageByte! {
//            completion(imageData)
//        } else {
//            completion(jpegData(compressionQuality: 1)!)
//        }
//    }
    
    func resizeByByte(maxByte: Int) -> String {
        var compressQuality: CGFloat = 1
        var imageData = Data()
        var imageByte = jpegData(compressionQuality: 1)?.count
        
        while imageByte! > maxByte {
            imageData = jpegData(compressionQuality: compressQuality)!
            imageByte = jpegData(compressionQuality: compressQuality)?.count
            compressQuality -= 0.2
        }
        
        //        return (UIImage.init(data: imageData)?.pngData()?.base64EncodedString())!
        return imageData.base64EncodedString()
    }
    
}

class MyTapOnImageGesture: UITapGestureRecognizer {
    
    var pos = -1
    
}
