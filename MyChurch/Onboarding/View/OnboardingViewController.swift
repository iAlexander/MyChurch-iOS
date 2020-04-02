// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import UIKit

class OnboardingViewController: ViewController {
    
    let images = [
        OnboardingPage(image: UIImage(imageLiteralResourceName: "onb_map"), bgImage: UIImage(imageLiteralResourceName: "onb_bg_a"), description: "Показуємо шлях \nдо найближчого храму"),
        OnboardingPage(image: UIImage(imageLiteralResourceName: "onb_calendar"), bgImage: UIImage(imageLiteralResourceName: "onb_bg_b"), description: "Нагадуємо про свята"),
        OnboardingPage(image: UIImage(imageLiteralResourceName: "onb_book"), bgImage: UIImage(imageLiteralResourceName: "onb_bg_a"), description: "Інформуємо про новини\nПравославної Церкви України"),
        OnboardingPage(image: UIImage(imageLiteralResourceName: "onb_script"), bgImage: UIImage(imageLiteralResourceName: "onb_bg_c"), description: "Молимося разом"),
        OnboardingPage(image: UIImage(imageLiteralResourceName: "onb_account"), bgImage: UIImage(imageLiteralResourceName: "onb_bg_b"), description: "Персоналізуємо \nінформацію для Вас")
    ]
    var currentIndex = 0 {
        willSet {
            self.rightBarItem.tag = newValue
            
            self.rightFooterButton.tag = newValue
            if self.rightFooterButton.tag == 4 {
                self.rightFooterButton.setAttributedText("Розпочати")
            } else {
                self.rightFooterButton.setAttributedText("Далі")
            }
            
            if newValue == self.selectedIndex {
                UIView.animate(withDuration: 0.25) {
                    self.rightBarItem.isOn = true
                }
            } else {
                UIView.animate(withDuration: 0.25) {
                    self.rightBarItem.isOn = false
                }
            }
        }
    }
    var selectedIndex = 0
    
    let leftBarItem = Label("Це стартовий екран", size: 17, fontWeight: .regular, numberOfLines: 1, color: .black)
    let rightBarItem: UISwitch = {
        let switcher = UISwitch(frame: CGRect(x: 0, y: 0, width: 52, height: 32))
        switcher.onTintColor = UIColor(red: 0.004, green: 0.478, blue: 0.898, alpha: 1)
        switcher.isOn = true
        switcher.tag = 0
        switcher.addTarget(self, action: #selector(changeCurrentIndex), for: .valueChanged)
        
        return switcher
    }()
    
    let collectionViewController: UICollectionViewController = {
        let collectionView = UICollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.collectionView.isPagingEnabled = true
        collectionView.collectionView.backgroundColor = .white
        
        return collectionView
    }()
    
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.hidesForSinglePage = true
        pageControl.numberOfPages = 5
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor(red: 0.858, green: 0.858, blue: 0.858, alpha: 1)
        pageControl.currentPageIndicatorTintColor = UIColor(red: 0.004, green: 0.475, blue: 0.898, alpha: 1)
        
        return pageControl
    }()
    
    let leftFooterButton: Button = {
        let button = Button("Пропустити", fontSize: 16, fontColor: UIColor(red: 0.529, green: 0.572, blue: 0.63, alpha: 1))
        button.addTarget(self, action: #selector(skip), for: .touchUpInside)
        
        return button
    }()
    let rightFooterButton: GradientButton = {
        let button = GradientButton("Далі", fontSize: 18, fontColor: .white, fontWeight: .bold, gradientColors: [UIColor(red: 0.004, green: 0.475, blue: 0.898, alpha: 1), UIColor(red: 0.004, green: 0.776, blue: 0.988, alpha: 1)])
        button.addTarget(self, action: #selector(nextItem), for: .touchUpInside)
        
        return button
    }()
    
    lazy var customAlert: ModalViewController = {
        let vc = ModalViewController(delegate: self)
        vc.modalPresentationStyle = .overFullScreen
        return vc
    }()
    
    override func loadView() {
        super.loadView()
        
        // Do any additional setup before loading the view.
        self.collectionViewController.collectionView.delegate = self
        self.collectionViewController.collectionView.dataSource = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.addSubviews([self.leftBarItem, self.rightBarItem, self.collectionViewController.collectionView, self.pageControl, self.leftFooterButton, self.rightFooterButton])
        self.collectionViewController.collectionView.showsHorizontalScrollIndicator = false
        self.collectionViewController.collectionView.register(OnboardingScreenCollectionViewCell.self, forCellWithReuseIdentifier: OnboardingScreenCollectionViewCell.reuseIdentifier)
        
        if let layout = self.collectionViewController.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        }
        
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !UserDefaults.standard.bool(forKey: UserDefaults.Keys.isPrivacyPolicy.rawValue) {
            self.present(self.customAlert, animated: false, completion: nil)
        }
    }
    
    private func setupLayout() {
        self.leftBarItem.anchor(top: self.view.topAnchor, leading: self.view.leadingAnchor, padding: UIEdgeInsets(top: 52, left: 16, bottom: 0, right: 16), size: CGSize(width: 0, height: 32))
        self.rightBarItem.anchor(top: self.view.topAnchor, leading: self.leftBarItem.trailingAnchor, trailing: self.view.trailingAnchor, padding: UIEdgeInsets(top: 52, left: 16, bottom: 0, right: 16), size: CGSize(width: 0, height: 32))
        self.collectionViewController.collectionView.anchor(top: self.rightBarItem.bottomAnchor, leading: self.view.leadingAnchor, trailing: self.view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))
        self.pageControl.anchor(bottom: self.leftFooterButton.topAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 96, right: 0))
        self.pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.leftFooterButton.anchor(top: self.collectionViewController.collectionView.bottomAnchor, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, padding: UIEdgeInsets(top: 16, left: 16, bottom: 26, right: 16), size: CGSize(width: 146, height: 46))
        self.rightFooterButton.anchor(top: self.collectionViewController.collectionView.bottomAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 16, bottom: 26, right: 16), size: CGSize(width: 146, height: 46))
    }

}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ModalDelegate {
    
    // MARK: Handlers
    
    @objc private func skip(_ sender: UIButton!) {
        if let tabBarController = self.tabBarController as? TabBarController {
            UIView.animate(withDuration: 0.1) {
                tabBarController.tabBarType = .main
            }
        }
    }
    
    @objc private func nextItem(_ sender: UIButton!) {
        if sender.tag == 4 {
            if let tabBarController = self.tabBarController as? TabBarController {
                UserData.defaultScreenIndex = self.selectedIndex
                UserData.isDefaultScreenChoosed = true
                
                UIView.animate(withDuration: 0.1) {
                    tabBarController.tabBarType = .main
                }
            }
        } else {
            if sender.tag == selectedIndex {
                UIView.animate(withDuration: 0.25) {
                    self.rightBarItem.isOn = true
                }
            } else {
                UIView.animate(withDuration: 0.25) {
                    self.rightBarItem.isOn = false
                }
            }
            
            let indexPath = IndexPath(item: self.currentIndex + 1, section: 0)
            self.collectionViewController.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
            self.currentIndex += 1
            self.pageControl.currentPage = self.currentIndex
        }
    }
    
    @objc private func changeCurrentIndex(_ sender: UISwitch!) {
        if sender.isOn {
            self.selectedIndex = sender.tag
        } else {
            self.selectedIndex = 0
        }
    }
    
    // MARK: ModalDelegate
    
    func dismiss() {
        UserDefaults.standard.set(true, forKey: UserDefaults.Keys.isPrivacyPolicy.rawValue)
        self.customAlert.dismiss(animated: false)
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: view.frame.width, height: view.frame.height - 200)
        return size
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 5
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print("velocity = \(velocity)")
        print("targetContentOffset pointee = \(targetContentOffset.pointee)")
        
        print("scrollView.contentSize.width = \(scrollView.contentSize.width)")
        let itemWidth = scrollView.contentSize.width / 5
        let inset = targetContentOffset.pointee.x
        let result = Int(5 - (scrollView.contentSize.width - inset) / itemWidth)
        self.pageControl.currentPage = result
        self.rightBarItem.tag = result
        
        self.rightFooterButton.tag = result
        if result == 4 {
            self.rightFooterButton.setAttributedText("Розпочати")
        } else {
            self.rightFooterButton.setAttributedText("Далі")
        }
        
        self.currentIndex = result
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("scrollViewDidEndDragging")
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingScreenCollectionViewCell.reuseIdentifier, for: indexPath) as? OnboardingScreenCollectionViewCell else { return UICollectionViewCell() }
        
        // Configure the cell
        let index = indexPath.item
        let image = images[index].image
        let bgImage = images[index].bgImage
        let text = images[index].description
        cell.configureWithData(image, description: text, bgImage: bgImage)
        
        return cell
    }
    
}
