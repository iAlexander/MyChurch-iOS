//
//  ChooseEparhiesViewController.swift
//  MyChurch
//
//  Created by Zhekon on 26.03.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

protocol SendDataEparhiyaDelegate: class {
    func eparhiyaName(name: String, eparhiyaId: Int)
}

class ChooseEparhiesViewController: UIViewController, UITableViewDelegate , UITableViewDataSource {
    
    let mainView = ChooseEparhiesView()
    let searchController = UISearchController(searchResultsController: nil)
    private let reuseIdentifierTableView = "CellTableView"
    var allHrams = [EparhiesList]()
    var filteredAllHrams = [EparhiesList]()
    weak var delegate: SendDataEparhiyaDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigView()
        setupSearchController()
        getData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.searchController.searchBar.frame = CGRect(x: 15, y: 15, width: self.view.bounds.width - 30, height: 50)
        self.view.addSubview(searchController.searchBar)
    }
    
    func getData() {
        getAllEparhies() { (result) in
            switch result {
            case .success(let data):
            self.allHrams = data.list ?? [EparhiesList]()
            self.filteredAllHrams = data.list ?? [EparhiesList]()
            self.mainView.hramTableView.reloadData()
            case .partialSuccess( _): break
            case .failure(let error): print(error)
            }
        }
    }
    
    //MARK : Table view
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
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
        delegate?.eparhiyaName(name: filteredAllHrams[indexPath.row].name ?? "", eparhiyaId: filteredAllHrams[indexPath.row].id ?? 0)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK : SearchController
    func filterRowsForSearchedText(_ searchText: String) {
        filteredAllHrams = allHrams.filter({( model : EparhiesList) -> Bool in
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
        self.title = "Єпархiï"
        self.mainView.hramTableView.delegate = self
        self.mainView.hramTableView.dataSource = self
        self.mainView.hramTableView.separatorStyle = .none
        mainView.hramTableView.register(HramTableViewCell.self, forCellReuseIdentifier: reuseIdentifierTableView)
    }
}

extension ChooseEparhiesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let term = searchController.searchBar.text {
            filterRowsForSearchedText(term)
        }
    }
}
