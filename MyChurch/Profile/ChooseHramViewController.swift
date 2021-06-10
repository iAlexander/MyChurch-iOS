//
//  ChooseHramViewController.swift
//  MyChurch
//
//  Created by Zhekon on 25.03.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit
import ANLoader

protocol SendDataDelegate: class {
    func hramName(name: String, hramId: Int)
}

class ChooseHramViewController: UIViewController, UITableViewDelegate , UITableViewDataSource {
    
    let mainView = ChooseHramView()
    let searchController = UISearchController(searchResultsController: nil)
    private let reuseIdentifierTableView = "CellTableView"
    var allHrams = [HramInfo]()
    var filteredAllHrams = [HramInfo]()
    weak var delegate: SendDataDelegate?
    var selfLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let lat = UserDefaults.standard.value(forKey: "lastLatitude") as? Float, let lon = UserDefaults.standard.value(forKey: "lastlongitude") as? Float {
            selfLocation = CLLocation(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lon))
        }
        ConfigView()
        ANLoader.showLoading("Завантаження...", disableUI: true)
        setupSearchController()
        getData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.searchController.searchBar.frame = CGRect(x: 15, y: 15, width: self.view.bounds.width - 30, height: 50)
        self.view.addSubview(searchController.searchBar)
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    func getData() {
        getAllHrams() { (result) in
            switch result {
            case .success(let data): ANLoader.hide();
                self.allHrams = data.list ?? [HramInfo]()
                if let location = self.selfLocation {
                    self.allHrams.sort(by: { $0.distance(to: location) < $1.distance(to: location) })
                }
                self.filteredAllHrams = self.allHrams
                self.mainView.hramTableView.reloadData()
            case .partialSuccess( _): ANLoader.hide();
            case .failure(let error): ANLoader.hide();
                print(error)
            }
        }
    }
    
    //MARK : Table view
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredAllHrams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierTableView, for: indexPath) as! HramTableViewCell
        cell.selectionStyle = .none
        cell.hramName.text = filteredAllHrams[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.hramName(name: filteredAllHrams[indexPath.row].name ?? "", hramId: filteredAllHrams[indexPath.row].id ?? 0)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK : SearchController
    func filterRowsForSearchedText(_ searchText: String) {
        filteredAllHrams = allHrams.filter({( model : HramInfo) -> Bool in
            return (model.name?.lowercased().contains(searchText.lowercased()) ?? false )
        })
        mainView.hramTableView.reloadData()
    }
    
    func setupSearchController() {
        definesPresentationContext = true
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.barTintColor = UIColor(red: 0.949, green: 0.976, blue: 0.996, alpha: 1)
        searchController.searchBar.backgroundImage = UIImage()
        if #available(iOS 13.0, *) {
            searchController.searchBar.searchTextField.backgroundColor = UIColor(red: 0.949, green: 0.976, blue: 0.996, alpha: 1)
        }
        searchController.searchBar.placeholder = ""
    }
    
    func ConfigView() {
        self.view.addSubview(mainView)
        self.mainView.frame = self.view.bounds
        self.title = "Прихід"
        self.mainView.hramTableView.delegate = self
        self.mainView.hramTableView.dataSource = self
        self.mainView.hramTableView.separatorStyle = .none
        mainView.hramTableView.register(HramTableViewCell.self, forCellReuseIdentifier: reuseIdentifierTableView)
    }
}

extension ChooseHramViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let term = searchController.searchBar.text {
            if term.trimmingCharacters(in: .whitespaces) != "" {
                filterRowsForSearchedText(term)
            } else {
                filteredAllHrams = allHrams
                mainView.hramTableView.reloadData()
            }
        }
    }
}
