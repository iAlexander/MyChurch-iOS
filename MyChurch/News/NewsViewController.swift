// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import UIKit

class NewsViewController: ViewController {
    
    lazy var vm = NewsViewModel(delegate: self)
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    let activityIndicatorView: UIActivityIndicatorView = {
        var activityIndicatorView: UIActivityIndicatorView
        
        if #available(iOS 13.0, *) {
            activityIndicatorView = UIActivityIndicatorView(style: .large)
        } else {
            // Fallback on earlier versions
            activityIndicatorView = UIActivityIndicatorView()
        }
        
        return activityIndicatorView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.addSubviews([self.tableView, self.activityIndicatorView])
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.reuseIdentifier)
        
        self.activityIndicatorView.startAnimating()
        vm.startFetchingData()
        
        setupNavBar()
        setupLayout()
    }
    
    private func setupNavBar() {
        self.navigationItem.rightBarButtonItems = [notificationhBarButtonItem, searchBarButtonItem]
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        super.searchBarButtonItem.action = #selector(openSearch(_:))
        super.notificationhBarButtonItem.action = #selector(openNotification(_:))
        
        self.navigationItem.title = "Новини"
    }
    
    private func setupLayout() {
        self.activityIndicatorView.anchor(centerY: self.view.centerYAnchor, centerX: self.view.centerXAnchor, size: CGSize(width: 75, height: 75))
        self.tableView.fillSuperview(padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
    
}

extension NewsViewController: NewsDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @objc private func openSearch(_ sender: UIButton!) {
        print("openSearch")
        // choose default screen (open onboarding)
        let alert: UIAlertController = {
            let alert = UIAlertController(title: "Скинути початковий екран", message: "Ви впевнені, що бажаєте повернутися до вибору початкового екрану?", preferredStyle: .alert)
            let action = UIAlertAction(title: "Так", style: .default) { (response) in
                UserData.isDefaultScreenChoosed = false
                
                if let tabBarController = self.tabBarController as? TabBarController {
                    UIView.animate(withDuration: 0.1) {
                        tabBarController.tabBarType = .onboarding
                    }
                }
            }
            alert.addAction(action)
            
            let cancelAction = UIAlertAction(title: "Скасувати", style: .cancel) { (response) in
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(cancelAction)
            
            return alert
        }()
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func openNotification(_ sender: UIButton!) {
        print("openNotification")
    }
    
    @objc func openDetails(_ sender: UIButton!) {
        print("openNotification")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewsViewModel.news?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseIdentifier, for: indexPath) as? NewsTableViewCell {
            let index = indexPath.row
            guard let data = NewsViewModel.news?[index] else { return UITableViewCell() }
            cell.configureWithData(data: data)
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NewsDetailsCollectionViewController(indexPath: indexPath)
            
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func didFinishFetchingData() {
        self.activityIndicatorView.stopAnimating()
        
        if NewsViewModel.news != nil {
            self.tableView.reloadData()
        }
    }
    
}
