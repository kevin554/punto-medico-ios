import GoogleMaps
import UIKit

class ContactUsController: UIViewController {

    @IBOutlet weak var mapContentView: UIView!
    var mapView: GMSMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let camera = GMSCameraPosition.camera(withLatitude: -17.7582584, longitude: -63.1932105, zoom: 14.5)
        mapView = GMSMapView.map(withFrame: mapContentView.bounds, camera: camera)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -17.7582584, longitude: -63.1932105)
        marker.map = mapView
        
        mapContentView.addSubview(mapView)
    }

}
