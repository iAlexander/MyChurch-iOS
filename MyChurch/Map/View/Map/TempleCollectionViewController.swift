// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import UIKit

class TempleCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    weak var delegate: SelectTempleDelegate?
    
    var data: [Temple] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = true

        // Register cell classes
        self.collectionView!.register(TempleCollectionViewCell.self, forCellWithReuseIdentifier: TempleCollectionViewCell.reuseIdentifier)

        // Do any additional setup after loading the view.
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 8
            layout.itemSize = CGSize(width: self.collectionView.frame.width - 16 - (self.collectionView.frame.width / 6), height: 120)
        }
    }

    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return data.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TempleCollectionViewCell.reuseIdentifier, for: indexPath) as! TempleCollectionViewCell
    
        // Configure the cell
        let data = self.data[indexPath.item]
        cell.configureWithData(data: data)
    
        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
        self.delegate?.selectTemple(indexPath: indexPath)
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        let item = x / view.frame.width
        let indexPath = IndexPath(item: Int(item), section: 0)
        self.delegate?.selectTemple(indexPath: indexPath)
    }

}

class TempleCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "TempleCollectionViewCell"
    
    let shadows: UIView = {
        let view = UIView()
        view.clipsToBounds = false
        view.layer.cornerRadius = 8
        
        return view
    }()
    let body: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    override func layoutSubviews() {
        let shadowPath = UIBezierPath(roundedRect: self.shadows.bounds, cornerRadius: 8)
        let shadowLayer = CALayer()
        shadowLayer.shadowPath = shadowPath.cgPath
        shadowLayer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        shadowLayer.shadowOpacity = 1
        shadowLayer.shadowRadius = 8
        shadowLayer.shadowOffset = CGSize(width: 0, height: 2)
        shadowLayer.bounds = self.shadows.bounds
        shadowLayer.position = self.shadows.center
    }
    
    func configureWithData(data: Temple) {
        setupShapes()
        setupLayout()
    }
    
    private func setupShapes() {
        self.contentView.addSubviews([self.shadows, self.body])
    }
    
    private func setupLayout() {
        self.shadows.fillSuperview(padding: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
        self.body.fillSuperview()
    }
    
}
