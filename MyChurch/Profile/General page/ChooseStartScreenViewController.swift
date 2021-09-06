//
//  ChooseStartScreenViewController.swift
//  MyChurch
//
//  Created by Zhekon on 29.04.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class ChooseStartScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let mainView = ChooseStartScreenView()
    let screensName = ["Карта", "Календар", "Новини", "Молитви", "Мій профіль"]
    
       override func viewDidLoad() {
           super.viewDidLoad()
           ConfigView()
           
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return screensName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = screensName[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserData.defaultScreenIndex = indexPath.row
        self.navigationController?.popViewController(animated: true)
    }
    
    func ConfigView() {
        self.view.addSubview(mainView)
        self.mainView.frame = self.view.bounds
        mainView.startTableView.delegate = self
        mainView.startTableView.dataSource = self
        self.title = ""
        mainView.startTableView.tableFooterView = UIView()
    }
    
}
