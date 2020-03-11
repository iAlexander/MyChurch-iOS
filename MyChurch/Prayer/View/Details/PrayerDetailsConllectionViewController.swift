// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import UIKit

class PrayerDetailsConllectionViewController: ViewController {
    
    convenience init(data: [Prayer], indexPath: IndexPath) {
        self.init()
        
        self.data = data
        self.currentIndexPath = indexPath
    }
    
    let collectionView: UICollectionViewController = {
        let collectionView = UICollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.collectionView.isPagingEnabled = true
        
        return collectionView
    }()
    
    var data: [Prayer] = []
    var currentIndexPath = IndexPath()
    
    override func loadView() {
        super.loadView()
        
        self.collectionView.collectionView.delegate = self
        self.collectionView.collectionView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.collectionView.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.collectionView.register(PrayerDetailsCollectionViewCell.self, forCellWithReuseIdentifier: PrayerDetailsCollectionViewCell.reuseIdentifier)
        
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        }
        
        self.view.addSubview(self.collectionView.collectionView)
        
        setupNavBar()
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Do any additional setup before appearing the view.
        self.collectionView.collectionView.selectItem(at: self.currentIndexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    private func setupNavBar() {
        self.navigationItem.leftBarButtonItems = [backBarButtonItem]
        self.navigationItem.rightBarButtonItems = [notificationhBarButtonItem]
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        super.backBarButtonItem.action = #selector(dismissViewController)
        super.notificationhBarButtonItem.action = #selector(openNotification)
    }
    
    private func setupLayout() {
        self.collectionView.collectionView.backgroundColor = .white
        
        self.collectionView.collectionView.fillSuperview()
    }
    
}

extension PrayerDetailsConllectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        print(data.count)
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PrayerDetailsCollectionViewCell.reuseIdentifier, for: indexPath) as? PrayerDetailsCollectionViewCell else { return UICollectionViewCell() }
        
        // Configure the cell
        let index = indexPath.item
        let data = self.data[index]
        cell.configureWithData(data: data)
        
        return cell
    }
    
    @objc func dismissViewController(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func openNotification(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
