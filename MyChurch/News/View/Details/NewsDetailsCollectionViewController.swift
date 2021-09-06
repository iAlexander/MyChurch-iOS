// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import UIKit

protocol NewsCellDelegate: AnyObject {
    func reloadCell(indexPath: IndexPath)
}

class NewsDetailsCollectionViewController: ViewController {
    
    convenience init(indexPath: IndexPath) {
        self.init()
        
        self.currentIndexPath = indexPath
    }
    
    let collectionView: UICollectionView = {
       let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.isPagingEnabled = true
        collectionView.alpha = 0
        return collectionView
    }()
    
    var currentIndexPath = IndexPath()
    weak var delegate: NewsCellDelegate?
    private var needScrollToSelecteditem = true
    
    override func loadView() {
        super.loadView()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
           super.notificationhBarButtonItem = UIBarButtonItem()
        // Do any additional setup after loading the view.
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.register(NewsDetailsCollectionViewCell.self, forCellWithReuseIdentifier: NewsDetailsCollectionViewCell.reuseIdentifier)
        
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        }
        
        self.view.addSubview(self.collectionView)
        setupNavBar()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.title = "Новини"
        if UserDefaults.standard.string(forKey: "BarearToken") == nil {
            self.navigationItem.rightBarButtonItem = nil
        }
        if needScrollToSelecteditem {
            collectionView.setNeedsLayout()
            collectionView.layoutIfNeeded()
            self.collectionView.selectItem(at: self.currentIndexPath, animated: false, scrollPosition: .centeredHorizontally)
            needScrollToSelecteditem = false
            UIView.animate(withDuration: 0.2) {
                self.collectionView.alpha = 1
            }
        }
    }
    
    private func setupNavBar() {
        self.navigationController!.navigationBar.tintColor = .white
        self.navigationItem.hidesBackButton = false
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        let icon = #imageLiteral(resourceName: "notification").withRenderingMode(.alwaysOriginal)
        let barButtonItem = UIBarButtonItem(image: icon, style: .plain, target: self, action: #selector(openNotification(_:)))
        self.navigationItem.rightBarButtonItem = barButtonItem
    }
    
    private func setupLayout() {
        self.view.backgroundColor = .white
        self.collectionView.backgroundColor = .white
        
        self.collectionView.fillSuperview()
    }
    
}

extension NewsDetailsCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: view.bounds.width, height: view.bounds.height)
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if needScrollToSelecteditem { return }
        if let id = NewsViewModel.news?[indexPath.row].id {
            self.markNewsAsRead(id: id)
        }
        self.delegate?.reloadCell(indexPath: indexPath)
        currentIndexPath = indexPath
        
    }
        
    @objc func openNotification(_ sender: Any) {
        let vc = NotificationViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func markNewsAsRead(id: Int) {
        if var readNews = UserDefaults.standard.stringArray(forKey: "readNews") {
            if !readNews.contains("\(id)") {
                readNews.append("\(id)")
                UserDefaults.standard.setValue(readNews, forKey: "readNews")
            }
        } else {
            let readNews = ["\(id)"]
            UserDefaults.standard.setValue(readNews, forKey: "readNews")
        }
    }
    
}
