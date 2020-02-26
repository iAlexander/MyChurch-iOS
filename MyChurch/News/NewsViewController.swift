// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import UIKit

class NewsViewController: ViewController {
    
    lazy var vm = NewsViewModel(delegate: self)
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.addSubview(self.tableView)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.reuseIdentifier)
        
        self.vm.startFetchingData()
        
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
        self.tableView.fillSuperview(padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
    
}

extension NewsViewController: NewsDelegate, UITableViewDelegate, UITableViewDataSource {
    
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
        if NewsViewModel.news != nil {
            self.tableView.reloadData()
        }
    }
    
    
    @objc private func openSearch(_ sender: UIButton!) {
        print("openSearch")
    }
    
    @objc func openNotification(_ sender: UIButton!) {
        print("openNotification")
    }
    
    @objc func openDetails(_ sender: UIButton!) {
        print("openNotification")
    }
    
}
