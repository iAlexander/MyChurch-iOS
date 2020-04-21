// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import UIKit

class NewsDetailsCollectionViewController: ViewController {
    
    convenience init(indexPath: IndexPath) {
        self.init()
        
        self.currentIndexPath = indexPath
    }
    
    let collectionView: UICollectionViewController = {
        let collectionView = UICollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.collectionView.isPagingEnabled = true
        collectionView.collectionView.isHidden = true
        
        return collectionView
    }()
    
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
        self.collectionView.collectionView.register(NewsDetailsCollectionViewCell.self, forCellWithReuseIdentifier: NewsDetailsCollectionViewCell.reuseIdentifier)
        
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
        self.collectionView.collectionView.selectItem(at: self.currentIndexPath, animated: false, scrollPosition: .centeredHorizontally)
        self.collectionView.collectionView.isHidden = false
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
        self.view.backgroundColor = .white
        self.collectionView.collectionView.backgroundColor = .white
        
        self.collectionView.collectionView.fillSuperview()
    }
    
}

extension NewsDetailsCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        return NewsViewModel.news!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsDetailsCollectionViewCell.reuseIdentifier, for: indexPath) as? NewsDetailsCollectionViewCell else { return UICollectionViewCell() }
        
        // Configure the cell
        if let data = NewsViewModel.news?[indexPath.item] {
            cell.configureWithData(data: data)
        }
        
        return cell
    }
    
    @objc func dismissViewController(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func openNotification(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
