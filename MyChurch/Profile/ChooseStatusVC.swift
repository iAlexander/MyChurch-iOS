//
//  ChooseStatusVC.swift
//  MyChurch
//
//  Created by Taras Tanskiy on 25.07.2021.
//  Copyright © 2021 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

protocol SendStatusDelegate: AnyObject {
    func statusType(name: String)
}

class ChooseStatusVC: UIViewController, UITableViewDelegate , UITableViewDataSource {
    
    let mainView = ChooseStatusView()
    var statusArray = ["Вірянин", "Член парафіяльної ради"]
    weak var delegate: SendStatusDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           self.navigationController!.navigationBar.tintColor = .white
           self.navigationController?.navigationBar.topItem?.title = ""
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        statusArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = statusArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.statusType(name: statusArray[indexPath.row])
        self.navigationController?.popViewController(animated: true)
    }
    
    func ConfigView() {
        self.view.addSubview(mainView)
        self.mainView.frame = self.view.bounds
        mainView.sanTableView.delegate = self
        mainView.sanTableView.dataSource = self
    }
    
}
