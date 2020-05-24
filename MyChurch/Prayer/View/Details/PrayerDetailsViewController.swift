// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import UIKit

class PrayerDetailsCollectionViewController: UIViewController {
    
    convenience init(indexPath: IndexPath, data: [Prayer]) {
        self.init()
        
        self.currentIndexPath = indexPath
        self.data = data
    }
    
    var currentIndexPath: IndexPath?
    var data: [Prayer] = []
    
    let collectionViewController: UICollectionViewController = {
        let collectionViewController = UICollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        collectionViewController.collectionView.isHidden = true
        collectionViewController.collectionView.isPagingEnabled = true
        collectionViewController.collectionView.showsHorizontalScrollIndicator = false
        collectionViewController.collectionView.contentInset = UIEdgeInsets(top: 56, left: 0, bottom: 16, right: 0)
        
        return collectionViewController
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
    let dismissLabel: Button = {
        let button = Button("Повернутися", fontSize: 14, fontColor: .lightGrayCustom)
        button.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        
        return button
    }()
    let dismissButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "arrow-down")
        let imageTint = UIImage(named: "arrow-down")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.setImage(imageTint, for: .highlighted)
        button.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        
        return button
    }()
    
    let titleLabel = Label()
    let textLabel = Label()
    
    override func loadView() {
        super.loadView()
        
        self.collectionViewController.collectionView.delegate = self
        self.collectionViewController.collectionView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.collectionViewController.collectionView.register(PrayerDetailsCollectionViewCell.self, forCellWithReuseIdentifier: PrayerDetailsCollectionViewCell.reuseIdentifier)
        
        if let layout = self.collectionViewController.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        }
        
        if #available(iOS 13.0, *) {
            self.view.addSubviews([self.collectionViewController.collectionView, self.dismissButton, self.activityIndicatorView])
        } else {
            self.view.addSubviews([self.collectionViewController.collectionView, self.dismissLabel, self.dismissButton, self.activityIndicatorView])
        }
        
        self.activityIndicatorView.startAnimating()
        
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Do any additional setup before appearing the view.
        if let indexPath = self.currentIndexPath {
            self.collectionViewController.collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .centeredHorizontally)
            self.activityIndicatorView.stopAnimating()
            self.collectionViewController.collectionView.isHidden = false
            self.currentIndexPath = nil
        }
    }
    
    private func setupLayout() {
        self.view.backgroundColor = .white
        self.collectionViewController.collectionView.backgroundColor = .white
        self.collectionViewController.collectionView.anchor(top: self.dismissButton.bottomAnchor, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor, padding: UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0))
        
//        self.scrollView.fillSuperview()
//
        if #available(iOS 13.0, *) {
            self.dismissButton.anchor(top: self.view.topAnchor, padding: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 16))
        } else {
            // Fallback on earlier versions
            self.dismissButton.anchor(top: self.view.topAnchor, padding: UIEdgeInsets(top: 48, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 16))
            self.dismissLabel.anchor(leading: self.view.leadingAnchor, bottom: self.dismissButton.topAnchor, trailing: self.view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
        self.dismissButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.activityIndicatorView.anchor(centerY: self.view.centerYAnchor, centerX: self.view.centerXAnchor)
    }
    
}

extension PrayerDetailsCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: view.frame.width, height: view.frame.height)
        return size
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PrayerDetailsCollectionViewCell.reuseIdentifier, for: indexPath) as? PrayerDetailsCollectionViewCell else { return UICollectionViewCell() }
        
        // Configure the cell
        let data = self.data[indexPath.item]
        cell.configureWithData(data: data)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    
    @objc func dismissViewController(_ sender: UIButton!) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
