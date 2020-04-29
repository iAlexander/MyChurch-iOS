//
//  ChooseSanViewController.swift
//  MyChurch
//
//  Created by Zhekon on 31.03.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

protocol SendDataSanDelegate: class {
    func sanType(name: String, eparhiyaId: Int)
}

class ChooseSanViewController: UIViewController, UITableViewDelegate , UITableViewDataSource {
    
    let mainView = ChooseSanView()
    var sanArray = [String]()
    weak var delegate: SendDataSanDelegate?
    var isPriest = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sanArray = sanArray.sorted()
        if isPriest {
            self.sanArray =   ["диякон","протодиякон","ієрей","протоієрей","священник","ієродиякон","ієромонах","ігумен"]
        } else {
            self.sanArray =   ["єпископ", "архiєпископ","митрополит"]
        }
        ConfigView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           self.navigationController!.navigationBar.tintColor = .white
           self.navigationController?.navigationBar.topItem?.title = ""
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sanArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = sanArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(sanArray[indexPath.row])
        delegate?.sanType(name: sanArray[indexPath.row], eparhiyaId: indexPath.row )
        self.navigationController?.popViewController(animated: true)
    }
    
    func ConfigView() {
        self.view.addSubview(mainView)
        self.mainView.frame = self.view.bounds
        mainView.sanTableView.delegate = self
        mainView.sanTableView.dataSource = self
    }
    
}
