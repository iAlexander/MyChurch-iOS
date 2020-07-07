//
//  NotificationViewController.swift
//  MyChurch
//
//  Created by Zhekon on 26.05.2020.
//  Copyright © 2020 Oleksandr Lohozinskyi. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, RefreshData {
    func needRefresh() {
        viewDidLoad()
    }
    
    let mainView = NotificationView()
    var userNotification = UserNotifocation()
    private let reuseIdentifierTableView = "NotificationCellTableView"
    var dates = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigView()
        getUserAllNotification() { (result) in
            switch result {
            case .success(let data):
                if data.data?.accessToken != nil {
                    UserDefaults.standard.set(data.data?.accessToken, forKey: "BarearToken")
                    self.viewDidLoad()
                } else {
                self.userNotification = data
                self.mainView.notificationTableView.delegate = self
                self.mainView.notificationTableView.dataSource = self
                self.mainView.notificationTableView.reloadData()
                }
            case .partialSuccess( _):  print("error")
            case .failure(let error):
                print(error.localizedDescription)
                print(error)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.navigationBar.tintColor = .white
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.userNotification.data?.list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierTableView, for: indexPath) as! NotificationCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        if !(self.userNotification.data?.list?[indexPath.row].read ?? false) {
            cell.notificationText.font =  UIFont.systemFont(ofSize: 16, weight: .bold)
        } else {
            cell.notificationImage.isHidden = true
        }
        cell.notificationText.text = self.userNotification.data?.list?[indexPath.row].title
        let date = self.userNotification.data?.list?[indexPath.row].createdAt?.strstr(needle: "T", beforeNeedle: true)
        let hours = self.userNotification.data?.list?[indexPath.row].createdAt?.strstr(needle: "T", beforeNeedle: false)
        let hourAndMinutes = hours?.strstr(needle: ".", beforeNeedle: true)
        cell.dataText.text = "\(date!.replacingOccurrences(of: "-", with: ".", options: .literal, range: nil))   \(hourAndMinutes?.prefix(5) ?? "")"
        dates.append("\(date!.replacingOccurrences(of: "-", with: ".", options: .literal, range: nil))   \(hourAndMinutes?.prefix(5) ?? "")")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NotificationDetailViewController()
        vc.date = dates[indexPath.row]
        vc.delegate = self
        vc.notificationId = self.userNotification.data?.list?[indexPath.row].id?.description as! String
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func ConfigView() {
        self.view.addSubview(mainView)
        self.mainView.frame = self.view.bounds
        self.title = "Повiдомлення"
        mainView.notificationTableView.register(NotificationCell.self, forCellReuseIdentifier: reuseIdentifierTableView)
    }
}
