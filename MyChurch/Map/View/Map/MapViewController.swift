// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import UIKit
import CoreLocation
import GoogleMaps

// delegate for selecting temple on a map/templesColectionViewController
protocol SelectTempleDelegate: class {
    func selectTemple(indexPath: IndexPath)
}

class MapViewController: ViewController {
    
    lazy var vm = MapViewModel(delegate: self)
    
    private let locationManager = CLLocationManager()
    private var mapView: GMSMapView!
    private var clusterManager: GMUClusterManager!
    
    var visibleRegion: GMSVisibleRegion? {
        didSet {
            print(">> MapViewController: visibleRegion has been changed")
        }
    }
    var selfLocation = CLLocationCoordinate2D(latitude: 50.45582, longitude: 30.5230025) {
        didSet {
            setMapCamera()
        }
    }
    
    let templesColectionViewController = TempleCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
    
    override func loadView() {
        super.loadView()
        
        // Do any additional setup before loading the view.
        self.locationManager.delegate = self
        self.templesColectionViewController.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        
        getLocation()
        configureMap()
        
        self.view.addSubviews([self.templesColectionViewController.collectionView])
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Do any additional setup before appearing the view.
        self.locationManager.startUpdatingLocation()
    }
    
    private func setupLayout() {
        self.templesColectionViewController.collectionView.backgroundColor = .clear
            
        self.templesColectionViewController.collectionView.anchor(leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor, size: CGSize(width: 0, height: 136))
    }

}

extension MapViewController: GMSMapViewDelegate, CLLocationManagerDelegate {
    
    private func configureMap() {
        // Configure mapView
        let camera = GMSCameraPosition.camera(withLatitude: self.selfLocation.latitude, longitude: self.selfLocation.longitude, zoom: 17)
        self.mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        self.mapView.delegate = self
        self.view = self.mapView
    }
    
    private func setMapCamera(duration: Double = 0.5) {
        CATransaction.begin()
        let latitude = self.selfLocation.latitude
        let longitude = self.selfLocation.longitude
        let coordinate = GMSCameraPosition(latitude: latitude, longitude: longitude, zoom: 12)
        
        CATransaction.setValue(duration, forKey: kCATransactionAnimationDuration)
        self.mapView.animate(to: coordinate)
        CATransaction.commit()
    }
    
    private func getLocation() {
        self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        self.locationManager.startUpdatingLocation()
        
        let status = CLLocationManager.authorizationStatus()
        switch status {
            case .notDetermined: self.locationManager.requestWhenInUseAuthorization()
            default: ()
        }
        
        // call view model for making request on API (getting temples)
        // view model is working via delegate MapDelegate, it's returning the result of API (4k temples)
        getData()
    }
    
    private func getData() {
        let latitude = String(self.selfLocation.latitude)
        let longitude = String(self.selfLocation.longitude)
        self.vm.startFetchingData(lt: latitude, lg: longitude)
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.last?.coordinate {
            self.selfLocation = currentLocation
        }
    }
    
}

extension MapViewController: MapDelegate, SelectTempleDelegate {
    
    // MARK: - MapDelegate
    func didFinishFetchingData(_ data: [Temple]?) {
        if let data = data {
            self.templesColectionViewController.data = data
        }
    }
    
    // MARK: - SelectTempleDelegate
    func selectTemple(indexPath: IndexPath) {
        print(indexPath)
    }
    
}

