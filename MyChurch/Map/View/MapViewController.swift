// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import UIKit
import CoreLocation
import GoogleMaps
import ANLoader
import MapKit

// delegate for selecting temple on a map/templesColectionViewController
protocol SelectTempleDelegate: class {
    func selectTemple(indexPath: IndexPath)
}

class MapViewController: ViewController, UISearchBarDelegate {
    
    lazy var vm = MapViewModel(delegate: self)
    let searchController = UISearchController(searchResultsController: nil)
    let churchTableView = UITableView()
    
    private let locationManager = CLLocationManager()
    private var mapView: GMSMapView!
    // private var clusterManager: GMUClusterManager!
    private let reuseIdentifierTableView = "CellTableView"
    var allChurch = [Temple]()
    var allChurchFiltered = [Temple]()
    
    var visibleRegion: GMSVisibleRegion? {
        didSet {
            print(">> MapViewController: visibleRegion has been changed")
        }
    }
    
    var selfLocation = CLLocationCoordinate2D()
    let templesColectionViewController = TempleCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
    
    override func loadView() {
        super.loadView()
        self.locationManager.delegate = self
        self.templesColectionViewController.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        
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
        self.view.addSubview(searchController.searchBar)
        self.view.addSubview(churchTableView)
        
        searchController.searchBar.showsCancelButton = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.locationManager.startUpdatingLocation()
        self.navigationController?.isNavigationBarHidden = true
        checkLayoutSearchController()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        checkLayoutSearchController()
        churchTableView.tableHeaderView = searchController.searchBar
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        searchController.isActive = true
    }
    
    private func setupLayout() {
        self.templesColectionViewController.collectionView.backgroundColor = .clear
        self.templesColectionViewController.collectionView.anchor(leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor,padding: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0), size: CGSize(width: 0, height: 120))
    }
    
    func checkLayoutSearchController() {
        let navBarHeight = view.safeAreaInsets.top
        if navBarHeight == 0 {
            self.searchController.searchBar.frame = CGRect(x: 10, y: 0, width: self.view.bounds.width - 20, height: 50)
            self.churchTableView.frame = CGRect(x: 0, y: 50, width: Int(self.view.bounds.width), height: 50)
        } else {
            self.searchController.searchBar.frame = CGRect(x: 10, y: 0, width: self.view.bounds.width - 20, height: 50)
            self.churchTableView.frame = CGRect(x: 0, y: 50, width: Int(self.view.bounds.width), height: 50)
        }
        if  self.allChurchFiltered.count <= 0 {
            self.churchTableView.frame = CGRect(x: 0, y: 50, width: Int(self.view.bounds.width), height: 50)
            self.view.layoutSubviews()
        } else {
            self.churchTableView.frame = CGRect(x: 0, y: 50, width: Int(self.view.bounds.width), height: Int(self.view.bounds.height - 250))
            self.view.layoutSubviews()
        }
    }
   
    func setupSearchController() {
        definesPresentationContext = true
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.barTintColor = .white
        searchController.searchBar.delegate = self

        //        searchController.searchBar.layer.cornerRadius = 11
        //        searchController.searchBar.clipsToBounds = true
        if #available(iOS 13.0, *) {
            searchController.searchBar.searchTextField.backgroundColor = .white
        }
        searchController.searchBar.placeholder = " Search..."
        searchController.searchBar.setImage(UIImage(), for: .clear, state: .normal)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            self.searchBarSearchButtonClicked(searchBar)
        }
    }
 
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
           searchBar.resignFirstResponder()
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
        let vc = DetailMapViewController()
        vc.templeInfo = allChurchFiltered[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        //        if allChurchFiltered[indexPath.row].type == "Кафедральний" {
        //            let vc = DetailMapKathedralViewController()
        //            vc.templeInfo = allChurchFiltered[indexPath.row]
        //            self.navigationController?.pushViewController(vc, animated: true)
        //        }else {
        //            let vc = DetailMapViewController()
        //            vc.templeInfo = allChurchFiltered[indexPath.row]
        //            self.navigationController?.pushViewController(vc, animated: true)
        //        }
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
        self.selfLocation = CLLocationCoordinate2D(latitude: (locationManager.location?.coordinate.latitude ?? 50.4546600), longitude: (locationManager.location?.coordinate.longitude ?? 30.5238000))
        getData()
        CATransaction.begin()
        let latitude = self.selfLocation.latitude
        let longitude = self.selfLocation.longitude
        let coordinate = GMSCameraPosition(latitude: latitude, longitude: longitude, zoom: 12)
        
        CATransaction.setValue(0.5, forKey: kCATransactionAnimationDuration)
        self.mapView.animate(to: coordinate)
        CATransaction.commit()
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
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        ANLoader.activityBackgroundColor = UIColor(red: 0.004, green: 0.475, blue: 0.898, alpha: 1)
        for position in self.allChurch {
            if position.lt.description == marker.position.latitude.description && position.lg.description == marker.position.longitude.description {
//                if position.type == "Кафедральний" {
//                    let vc = DetailMapKathedralViewController()
//                    vc.templeInfo = position
//                    self.navigationController?.pushViewController(vc, animated: true)
//                    break
//                }else {
                    let vc = DetailMapViewController()
                    vc.templeInfo = position
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
            //    }
            }
        }
    return true
}
    
    //    // MARK: - CLLocationManagerDelegate
    //    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    //    }
}

extension MapViewController: MapDelegate, SelectTempleDelegate {
    
    // MARK: - MapDelegate
    func didFinishFetchingData(_ data: [Temple]?) {
        ANLoader.hide()
        if let data = data {
            
            for (index, item) in data.enumerated() {
                let endLocation = CLLocation(latitude: data[index].lt, longitude: data[index].lg)
                let distance = (self.locationManager.location?.distance(from: endLocation) ?? 0) / 1000
                print(" \(String(format:"%.02f", distance)) KMs ")
                let itemFullData = Temple(id: item.id, name: item.name, lt: item.lt, lg: item.lg
                    , distance: distance)
                self.allChurch.append(itemFullData)
            }
               self.allChurch = self.allChurch.sorted(by: { $0.distance! < ($1.distance!)})
            for item in data {
                let position = CLLocationCoordinate2D(latitude: (Double(item.lt)), longitude: Double(item.lg))
                let marker = GMSMarker(position: position)
                marker.title = nil
                marker.snippet = nil
                marker.map = self.mapView
                marker.icon = UIImage(named: "marker")
            }
            self.templesColectionViewController.data = self.allChurch
        }
    }
    
    // MARK: - SelectTempleDelegate
    func selectTemple(indexPath: IndexPath) {
        if allChurch.count > 0 {
            CATransaction.begin()
            let latitude = Double(allChurch[indexPath.row].lt) ?? 0.0
            let longitude = Double(allChurch[indexPath.row].lg) ?? 0.0
            let coordinate = GMSCameraPosition(latitude: latitude, longitude: longitude, zoom: 16)
            
            CATransaction.setValue(0.5, forKey: kCATransactionAnimationDuration)
            self.mapView.animate(to: coordinate)
            CATransaction.commit()
        }
    }
}




