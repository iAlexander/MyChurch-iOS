// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import UIKit
import AVFoundation

class PrayerViewController: ViewController {
    
    lazy var vm = PrayerViewModel(delegate: self)
    
    //    var player: AVAudioPlayer? {
    //        didSet {
    //
    //        }
    //    }
    
    //    let volume = AVAudioSession.sharedInstance().outputVolume
    
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
    
    let playerViewController = PlayerViewController()
    
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
        self.view.addSubviews([self.segmentedControl, self.tableView, self.activityIndicatorView, self.playerViewController.view])
        
        self.navigationItem.title = "Молитви"
        
        self.activityIndicatorView.startAnimating()
        vm.startFetchingData()
        
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Do any additional setup after appearing the view.
        //        self.playerViewController.configure()
        //        self.playerViewController.playButton.addTarget(self, action: #selector(playAudio), for: .touchUpInside)
        //        self.playerViewController.nextButton.addTarget(self, action: #selector(nextAudio), for: .touchUpInside)
    }
    
    private func setupLayout() {
        self.activityIndicatorView.backgroundColor = .white
        
        // Auto Layout constraints
        self.activityIndicatorView.anchor(centerY: self.view.centerYAnchor, centerX: self.view.centerXAnchor, size: CGSize(width: 75, height: 75))
        self.segmentedControl.anchor(top: self.view.topAnchor, leading: self.view.leadingAnchor, trailing: self.view.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16))
        self.tableView.anchor(top: self.segmentedControl.bottomAnchor, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor, padding: UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0))
        self.playerViewController.view.anchor(leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor, size: CGSize(width: 0, height: 65))
    }
    
}

extension PrayerViewController: PrayerDelegate, UITableViewDelegate, UITableViewDataSource, AVAudioPlayerDelegate {
    
    func didFinishFetchingData() {
        self.activityIndicatorView.stopAnimating()
        self.segmentedControl.isUserInteractionEnabled = true
        
        if let data = PrayerViewModel.prayers?[PrayerType.morning.rawValue.uppercased()] {
            self.data = data
        }
    }
    
    func didFinishFetchingAudio() {
        //        if let data = PrayerViewModel.currentAudioData {
        //            self.player = try! AVAudioPlayer(data: data)
        //            self.player?.play()
        //        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PrayerTableViewCell.reuseIdentifier) as? PrayerTableViewCell else { return UITableViewCell() }
        
        let index = indexPath.item
        let title = self.data[index].title ?? ""
        let text = self.data[index].text ?? ""
        let audioUrl = vm.makePath(data: self.data[index].file)
        
        cell.configureWithData(title: title, text: text, audioUrl: audioUrl)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Open prayer details
        let vc = PrayerDetailsCollectionViewController(indexPath: indexPath, data: self.data)
        self.present(vc, animated: true)
        
        // Play audio
        //        let audioUrl = vm.makePath(data: data.file)
        //        getAudio(with: audioUrl)
    }
    
    func getAudio(with urlString: String?) {
        guard let urlString = urlString else { return }
        guard let url = URL(string: urlString) else { return }
        
        vm.startFetchingAudio(url: url)
    }
    
    @objc private func playAudio(_ sender: UIButton!) {}
    
    @objc private func nextAudio(_ sender: UIButton!) {}
    
    @objc private func indexChanged(_ sender: UISegmentedControl!) {
        switch sender.selectedSegmentIndex {
            case 0:
                if let data = PrayerViewModel.prayers?[PrayerType.morning.rawValue.uppercased()] {
                    self.data = data
                } else {
                    // should handle empty segment
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
    
}
