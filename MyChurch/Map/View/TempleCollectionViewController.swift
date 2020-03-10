// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import UIKit
import MSPeekCollectionViewDelegateImplementation

class TempleCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    weak var delegate: SelectTempleDelegate?
    var behavior: MSCollectionViewPeekingBehavior!

    var data: [Temple] = [] {
        didSet {
            print( self.data)
            self.data = self.data.sorted(by: { $0.distance < ($1.distance)})
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        behavior = MSCollectionViewPeekingBehavior(cellSpacing: 10)
        collectionView.configureForPeekingBehavior(behavior: behavior)
        self.clearsSelectionOnViewWillAppear = true
        
        self.collectionView!.register(TempleCollectionViewCell.self, forCellWithReuseIdentifier: TempleCollectionViewCell.reuseIdentifier)
        
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
        let data = self.data[indexPath.item]
        cell.configureWithData(data: data)
        
        cell.tapAction  = { (cell) in
         //   print(collectionView.indexPath(for: cell)!.row)
            if (UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!)) {
                UIApplication.shared.openURL(URL(string:
                    "comgooglemaps://" + "?daddr=\(Double(data.lt) ?? 0.0),\(Double(data.lg) ?? 0.0)&zoom=12&directionsmode=walking")!)
            } else {
                let alertController = UIAlertController(title: "Повiдомлення", message: "Встановiть будь ласка додаток 'Google Map'", preferredStyle: .alert)
                let actionCancel = UIAlertAction(title: "закрити", style: .cancel) { (action:UIAlertAction) in
                }
                alertController.addAction(actionCancel)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint)
        self.delegate?.selectTemple(indexPath: visibleIndexPath!)
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
       behavior.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint)
        if visibleIndexPath != nil {
            self.delegate?.selectTemple(indexPath: visibleIndexPath!)
        } else {
            return
        }
    }

}

class TempleCollectionViewCell: UICollectionViewCell {
    
    var tapAction: ((UICollectionViewCell) -> Void)?
    
    static let reuseIdentifier = "TempleCollectionViewCell"
    let churchName = UILabel()
    let distance = UILabel()
    let createRouteView = UIView()
    private let layerBlue = CAGradientLayer()
    let createRouteButton = UIButton()
    
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
        setupData(data: data)
    }
    
    private func setupData(data: Temple) {
        churchName.text = data.name
        distance.text = "\(String(Int(data.distance))) км"
    }
    
    private func setupShapes() {
        self.contentView.addSubviews([self.shadows, self.body])
    }
    
    private func setupLayout() {
        self.shadows.fillSuperview(padding: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4))
        
        self.addSubview(churchName)
        churchName.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        churchName.numberOfLines = 0
        churchName.pin.top(10).horizontally(15).height(45)
        
        self.addSubview(distance)
        distance.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        distance.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        distance.pin.below(of: churchName).marginTop(8).horizontally(15).height(15)
        
        self.addSubview(createRouteView)
        createRouteView.layer.cornerRadius = 6
        layerBlue.colors = [
            UIColor(red: 0.004, green: 0.475, blue: 0.898, alpha: 1).cgColor,
            UIColor(red: 0.004, green: 0.776, blue: 0.988, alpha: 1).cgColor
        ]
        layerBlue.locations = [0, 1]
        layerBlue.startPoint = CGPoint(x: 0.25, y: 0.5)
        layerBlue.endPoint = CGPoint(x: 0.75, y: 0.5)
        layerBlue.cornerRadius = 5
        layerBlue.position = createRouteView.center
        createRouteView.layer.addSublayer(layerBlue)
        
        createRouteView.pin.right(15).bottom(16).height(25).width(135)
        layerBlue.pin.all()
        
        createRouteView.addSubview(createRouteButton)
        createRouteButton.setTitle("Прокласти маршрут", for: .normal)
        createRouteButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        createRouteButton.pin.all()
        
        createRouteButton.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        
        self.body.fillSuperview()
    }
    
    @objc func buttonTap(sender: AnyObject) {
        tapAction?(self)
    }
}
