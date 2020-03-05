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
    let searchController = UISearchController(searchResultsController: nil)
    let churchTableView = UITableView()
    
    private let locationManager = CLLocationManager()
    private var mapView: GMSMapView!
    private var clusterManager: GMUClusterManager!
    private let reuseIdentifierTableView = "CellTableView"
    var allChurch = [Temple]()
    var allChurchFiltered = [Temple]()
    
    var visibleRegion: GMSVisibleRegion? {
        didSet {
            print(">> MapViewController: visibleRegion has been changed")
        }
    }
    //var selfLocation = CLLocationCoordinate2D(latitude: 50.45582, longitude: 30.5230025)
    var selfLocation = CLLocationCoordinate2D()
    //    {
    //        didSet {
    //            setMapCamera()
    //        }
    //    }
    
    let templesColectionViewController = TempleCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
    
    override func loadView() {
        super.loadView()
        // Do any additional setup before loading the view.
        self.locationManager.delegate = self
        self.templesColectionViewController.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        
        getLocation()
        configureMap()
        
        self.view.addSubviews([self.templesColectionViewController.collectionView])
        setupLayout()
        self.mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        churchTableView.register(ChurchTableViewCell.self, forCellReuseIdentifier: reuseIdentifierTableView)
        mapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: 130, right: 5)
        churchTableView.delegate = self
        churchTableView.dataSource = self
        churchTableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.locationManager.startUpdatingLocation()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let navBarHeight = view.safeAreaInsets.top
        if navBarHeight == 0 {
            self.searchController.searchBar.frame = CGRect(x: 10, y: 0, width: self.view.bounds.width - 20, height: 50)
            self.churchTableView.frame = CGRect(x: 0, y: 50, width: Int(self.view.bounds.width), height: 50)
        } else {
            self.searchController.searchBar.frame = CGRect(x: 10, y: 0, width: self.view.bounds.width - 20, height: 50)
            self.churchTableView.frame = CGRect(x: 0, y: 50, width: Int(self.view.bounds.width), height: 50)
        }
        self.view.addSubview(searchController.searchBar)
        self.view.addSubview(churchTableView)
        churchTableView.tableHeaderView = searchController.searchBar
    }
    
    private func setupLayout() {
        self.templesColectionViewController.collectionView.backgroundColor = .clear
        self.templesColectionViewController.collectionView.anchor(leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor, size: CGSize(width: 0, height: 136))
    }
        
    func setupSearchController() {
        definesPresentationContext = true
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.barTintColor = .white
//        searchController.searchBar.layer.cornerRadius = 11
//        searchController.searchBar.clipsToBounds = true
        if #available(iOS 13.0, *) {
            searchController.searchBar.searchTextField.backgroundColor = .white
        }
        searchController.searchBar.placeholder = " Search..."
    }
    
    func filterRowsForSearchedText(_ searchText: String) {
        self.allChurchFiltered = allChurch.filter({( model : Temple) -> Bool in
            return model.name.lowercased().contains(searchText.lowercased())
        })
        if  self.allChurchFiltered.count <= 0 {
            self.churchTableView.frame = CGRect(x: 0, y: 50, width: Int(self.view.bounds.width), height: 50)
        } else {
            self.churchTableView.frame = CGRect(x: 0, y: 50, width: Int(self.view.bounds.width), height: Int(self.view.bounds.height - 250))
        }
        self.view.layoutSubviews()
        churchTableView.reloadData()
    }
}

extension MapViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allChurchFiltered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierTableView, for: indexPath) as! ChurchTableViewCell
        cell.invitedLabel.text = self.allChurchFiltered[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(allChurchFiltered[indexPath.row].name)
    }
}

extension MapViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let term = searchController.searchBar.text {
            filterRowsForSearchedText(term)
        }
    }
}

extension MapViewController: GMSMapViewDelegate, CLLocationManagerDelegate {
    
    private func configureMap() {
        // Configure mapView
        let camera = GMSCameraPosition.camera(withLatitude: self.selfLocation.latitude, longitude: self.selfLocation.longitude, zoom: 17)
        self.mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        self.mapView.delegate = self
        self.view = self.mapView
        setMapCamera()
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
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.startUpdatingLocation()
        
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .notDetermined: self.locationManager.requestWhenInUseAuthorization()
        default: ()
        }

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
            // call view model for making request on API (getting temples)
            // view model is working via delegate MapDelegate, it's returning the result of API (4k temples)
            getData()
            CATransaction.begin()
            let latitude = self.selfLocation.latitude
            let longitude = self.selfLocation.longitude
            let coordinate = GMSCameraPosition(latitude: latitude, longitude: longitude, zoom: 12)
            
            CATransaction.setValue(0.5, forKey: kCATransactionAnimationDuration)
            self.mapView.animate(to: coordinate)
            CATransaction.commit()
            
        }
    }
}

extension MapViewController: MapDelegate, SelectTempleDelegate {
    
    // MARK: - MapDelegate
    func didFinishFetchingData(_ data: [Temple]?) {
        if let data = data {
            self.allChurch = data.sorted(by: { $0.distance < ($1.distance)})
          //  self.allChurch = self.allChurch.sorted(by: { $0.distance < ($1.distance)})
            for item in data {
                let position = CLLocationCoordinate2D(latitude: (Double(item.lt))!, longitude: Double(item.lg)!)
                let marker = GMSMarker(position: position)
                marker.title = nil
                marker.snippet = nil
                marker.map = self.mapView
                marker.icon = UIImage(named: "marker")
            }
            self.templesColectionViewController.data = data
        }
    }
    
    // MARK: - SelectTempleDelegate
    func selectTemple(indexPath: IndexPath) {
        if allChurch.count > 0 {
            CATransaction.begin()
            let latitude = Double(allChurch[indexPath.row].lt) ?? 0.0
            let longitude = Double(allChurch[indexPath.row].lg) ?? 0.0
            let coordinate = GMSCameraPosition(latitude: latitude, longitude: longitude, zoom: 16)
            print(allChurch[indexPath.row].name)

            CATransaction.setValue(0.5, forKey: kCATransactionAnimationDuration)
            self.mapView.animate(to: coordinate)
            CATransaction.commit()
        }
    }
}




