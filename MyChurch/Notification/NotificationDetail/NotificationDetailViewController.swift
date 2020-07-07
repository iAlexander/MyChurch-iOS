//
//  NotificationViewController.swift
//  MyChurch
//
//  Created by Zhekon on 28.05.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

protocol RefreshData: class {
    func needRefresh()
}

class NotificationDetailViewController: UIViewController {
    
    let mainView = NotificationDetailView()
    var date = String()
    var notificationId = String()
    weak var delegate: RefreshData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigView()
        getUserDetailNotification(notificationId: notificationId) { (result) in
            switch result {
            case .success(let data):
                if data.accessToken != nil {
                    UserDefaults.standard.set(data.accessToken, forKey: "BarearToken")
                    self.viewDidLoad()
                } else {
                    self.mainView.textNotification.text = data.data?.text
                }
            case .partialSuccess( _):  print("error")
            case .failure(let error):
                print(error.localizedDescription)
                print(error)
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        delegate?.needRefresh()
    }
 
    func ConfigView() {
        self.view.addSubview(mainView)
        self.mainView.frame = self.view.bounds
        mainView.date.text = self.date
    }
}
