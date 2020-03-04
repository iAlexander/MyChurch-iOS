// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import UIKit

class PrayerViewController: ViewController {
    
    lazy var vm = PrayerViewModel(delegate: self)
    
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.insertSegment(withTitle: PrayerType.morning.rawValue, at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: PrayerType.evening.rawValue, at: 1, animated: true)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(indexChanged), for: .valueChanged)
        segmentedControl.isUserInteractionEnabled = false
        
        if #available(iOS 13.0, *) {
            segmentedControl.selectedSegmentTintColor = UIColor(red: 0.004, green: 0.475, blue: 0.898, alpha: 1)
        } else {
            // Fallback on earlier versions
            segmentedControl.tintColor = UIColor(red: 0.004, green: 0.475, blue: 0.898, alpha: 1)
        }
        
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 0.004, green: 0.475, blue: 0.898, alpha: 1)], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        
        return segmentedControl
    }()
    
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
    
    var data: [Prayer] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func loadView() {
        super.loadView()
        
        // Do any additional setup before loading the view.
        self.tableView.register(PrayerTableViewCell.self, forCellReuseIdentifier: PrayerTableViewCell.reuseIdentifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.addSubviews([self.segmentedControl, self.tableView, self.activityIndicatorView])
        
        self.navigationItem.title = "Молитви"
        
        self.activityIndicatorView.startAnimating()
        
        vm.startFetchingData()
        
        setupLayout()
    }
    
    private func setupLayout() {
        self.activityIndicatorView.backgroundColor = .white
        
        // Auto Layout constraints
        self.activityIndicatorView.anchor(centerY: self.view.centerYAnchor, centerX: self.view.centerXAnchor, size: CGSize(width: 75, height: 75))
        self.segmentedControl.anchor(top: self.view.topAnchor, leading: self.view.leadingAnchor, trailing: self.view.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16))
        self.tableView.anchor(top: self.segmentedControl.bottomAnchor, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor, padding: UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0))
    }
    
}

extension PrayerViewController: PrayerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @objc private func indexChanged(_ sender: UISegmentedControl!) {
        switch sender.selectedSegmentIndex {
            case 0:
                if let data = PrayerViewModel.prayers?[PrayerType.morning.rawValue.uppercased()] {
                    self.data = data
                } else {
                    // shpuld handle empty segment
                    self.data = []
                }
            case 1:
                if let data = PrayerViewModel.prayers?[PrayerType.evening.rawValue.uppercased()] {
                    self.data = data
                } else {
                    // shpuld handle empty segment
                    self.data = []
                }
            default: ()
        }
    }
    
    func didFinishFetchingData() {
        self.activityIndicatorView.stopAnimating()
        self.segmentedControl.isUserInteractionEnabled = true
        
        if let data = PrayerViewModel.prayers?[PrayerType.morning.rawValue.uppercased()] {
            self.data = data
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PrayerTableViewCell.reuseIdentifier) as? PrayerTableViewCell else { return UITableViewCell() }
        
        let index = indexPath.item
        let title = self.data[index].title ?? ""
        let text = self.data[index].text ?? ""
        
        cell.configureWithData(title: title, text: text)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PrayerDetailsConllectionViewController(data: self.data, indexPath: indexPath)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
