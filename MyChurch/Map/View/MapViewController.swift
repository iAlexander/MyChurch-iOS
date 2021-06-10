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

class CustomSearchBar: UISearchBar {

override func setShowsCancelButton(_ showsCancelButton: Bool, animated: Bool) {
    super.setShowsCancelButton(false, animated: false)
}}

class CustomSearchController: UISearchController {

lazy var _searchBar: CustomSearchBar = {
    [unowned self] in
    let customSearchBar = CustomSearchBar(frame: CGRect.zero)
    return customSearchBar
    }()

override var searchBar: UISearchBar {
    get {
        return _searchBar
    }
}}


class MapViewController: ViewController, UISearchBarDelegate {
    
    lazy var vm = MapViewModel(delegate: self)
    let searchController = CustomSearchController(searchResultsController: nil)
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
    
    var selfLocation = CLLocationCoordinate2D() {
        didSet {
            UserDefaults.standard.setValue(Float(selfLocation.latitude), forKey: "lastLatitude")
            UserDefaults.standard.setValue(Float(selfLocation.longitude), forKey: "lastlongitude")
        }
    }
    let templesColectionViewController = TempleCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
    
    override func loadView() {
        super.loadView()
        self.locationManager.delegate = self
        self.templesColectionViewController.delegate = self
        self.templesColectionViewController.collectionView.alpha = 0
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
        self.title = "Карта"
        longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress))
        longPressRecognizer.minimumPressDuration = 0.1
        longPressRecognizer.delegate = self
        mapView.addGestureRecognizer(longPressRecognizer)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.allChurchFiltered.isEmpty {
                self.churchTableView.frame = CGRect(x: 0, y: 50, width: Int(self.view.bounds.width), height: 50)
            } else {
                self.churchTableView.frame = CGRect(x: 0, y: 50, width: Int(self.view.bounds.width), height: Int(self.view.frame.height - keyboardSize.height))
            }
            self.view.layoutSubviews()
          }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.allChurchFiltered.isEmpty {
            self.churchTableView.frame = CGRect(x: 0, y: 50, width: Int(self.view.bounds.width), height: 50)
        } else {
            self.churchTableView.frame = CGRect(x: 0, y: 50, width: Int(self.view.bounds.width), height: Int(self.view.frame.height - 50))
        }
        self.view.layoutSubviews()
    }
    
    var longPressRecognizer = UILongPressGestureRecognizer()
    
    @objc func longPress(_ sender: UILongPressGestureRecognizer) {
        if searchController.searchBar.text?.isEmpty ?? true {
            searchController.searchBar.resignFirstResponder()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.locationManager.startUpdatingLocation()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        searchController.isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        UIView.animate(withDuration: 0.3) {
            self.templesColectionViewController.collectionView.alpha = 1
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        self.templesColectionViewController.collectionView.alpha = 0
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        searchController.searchBar.frame = CGRect(x: 10, y: 0, width: self.view.bounds.width - 20, height: 50)
        searchController.searchBar.showsCancelButton = false
        churchTableView.tableHeaderView = searchController.searchBar
    }
    
    private func setupLayout() {
        self.templesColectionViewController.collectionView.backgroundColor = .clear
        self.templesColectionViewController.collectionView.anchor(leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor,padding: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0), size: CGSize(width: 0, height: 120))
    }
    
    func checkLayoutSearchController(keyboardHeight: CGFloat) {
//        let navBarHeight = view.safeAreaInsets.top
//        if navBarHeight == 0 {
//            self.searchController.searchBar.frame = CGRect(x: 10, y: 0, width: self.view.bounds.width - 20, height: 50)
//            self.churchTableView.frame = CGRect(x: 0, y: 50, width: Int(self.view.bounds.width), height: 50)
//        } else {
//            self.searchController.searchBar.frame = CGRect(x: 10, y: 0, width: self.view.bounds.width - 20, height: 50)
//            self.churchTableView.frame = CGRect(x: 0, y: 50, width: Int(self.view.bounds.width), height: 50)
//        }
        if self.allChurchFiltered.isEmpty {
            self.churchTableView.frame = CGRect(x: 0, y: 50, width: Int(self.view.bounds.width), height: 50)
        } else {
            self.churchTableView.frame = CGRect(x: 0, y: 50, width: Int(self.view.bounds.width), height: Int(self.view.frame.height - keyboardHeight))
        }
        self.view.layoutSubviews()
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
        searchController.searchBar.placeholder = "Знайти храм"
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
            return model.name.lowercased().contains(searchText.lowercased()) || model.locality!.lowercased().contains(searchText.lowercased())
        })
        if self.allChurchFiltered.isEmpty {
            self.churchTableView.frame = CGRect(x: 0, y: 50, width: Int(self.view.bounds.width), height: 50)
        } else {
            self.churchTableView.frame = CGRect(x: 0, y: 50, width: Int(self.view.bounds.width), height: Int(self.view.frame.height))
        }
        self.view.layoutSubviews()
        churchTableView.reloadData()
    }
    
    private func presentNoInternetAlert() {
        let vc = NoInternetAlert()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
}

extension MapViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allChurchFiltered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierTableView, for: indexPath) as! ChurchTableViewCell
        cell.invitedLabel.text = "\(self.allChurchFiltered[indexPath.row].locality ?? ""), \(self.allChurchFiltered[indexPath.row].name)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchController.searchBar.resignFirstResponder()
        getDetailTemple(id:allChurchFiltered[indexPath.row].id) { (result) in
            switch result {
            case .success(let data):
                self.createFirebaseAnalytics(itemID: "id 1", itemName: "Экран карты", contentType: "Пользователь воспользовался поиском и переходит на детальный экран карт")
                if data.data?.dioceseType?.id == 7 {
                    let vc = DetailMapKathedralViewController()
                    vc.templeInfo = self.allChurchFiltered[indexPath.row]
                    DispatchQueue.main.async {
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                } else {
                    let vc = DetailMapViewController()
                    vc.templeInfo = self.allChurchFiltered[indexPath.row]
                    DispatchQueue.main.async {
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            case .partialSuccess( _): break
            case .failure(let error):
                print(error)
            }
        }
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
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.getData()
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
                getDetailTemple(id:position.id) { (result) in
                    switch result {
                    case .success(let data):
                        self.createFirebaseAnalytics(itemID: "id 1", itemName: "Экран карты", contentType: "Пользователь воспользовался поиском и переходит на детальный экран карт")
                        if data.data?.dioceseType?.id == 7 {
                            let vc = DetailMapKathedralViewController()
                            vc.templeInfo = position
                            DispatchQueue.main.async {
                                self.navigationController?.pushViewController(vc, animated: true)
                            }
                        } else {
                            let vc = DetailMapViewController()
                            vc.templeInfo = position
                            DispatchQueue.main.async {
                                self.navigationController?.pushViewController(vc, animated: true)
                            }
                        }
                    case .partialSuccess( _): break
                    case .failure(let error):
                        print(error)
                    }
                }
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
        self.allChurch.removeAll()
        ANLoader.hide()
        if let data = data {
            for (index, item) in data.enumerated() {
                let endLocation = CLLocation(latitude: data[index].lt, longitude: data[index].lg)
                var distance: Double?
                if let location = self.locationManager.location {
                    distance = location.distance(from: endLocation) / 1000
                }
                let itemFullData = Temple(id: item.id, name: item.name, lt: item.lt, lg: item.lg
                    , distance: distance, locality: item.locality ?? "")
                self.allChurch.append(itemFullData)
            }
            self.allChurch = self.allChurch.sorted(by: { $0.distance ?? 0 < ($1.distance ?? 0)})
            for item in data {
                let position = CLLocationCoordinate2D(latitude: (Double(item.lt)), longitude: Double(item.lg))
                let marker = GMSMarker(position: position)
                marker.title = nil
                marker.snippet = nil
                marker.map = self.mapView
                marker.icon = UIImage(named: "marker")
            }
            self.templesColectionViewController.data = self.allChurch
        } else if UserDefaults.standard.bool(forKey: "NoInternetAlertWasPresented") == false {
            self.presentNoInternetAlert()
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




extension MapViewController : UIGestureRecognizerDelegate
{
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool
    {
        return true
    }
}
