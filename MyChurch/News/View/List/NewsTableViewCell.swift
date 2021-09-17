// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import UIKit
import SDWebImage

class NewsTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "NewsTableViewCell"
    
    let elevatedView: UIView = {
        let view = UIView()
        view.elevate(cornerRadius: 8, elevation: 2)
        view.backgroundColor = .white
        
        return view
    }()
    
    var data: NewsWordPressModel?
    let newsImageView = ImageView(cornerRadius: .defaultRadius)
    
    let titleLabel = Label()
    let leftSubtitleLabel = Label()
    let centerSubtitleLabel = Label()
    let rightSubtitleLabel = Label()
    
    func configureWithData(data: NewsWordPressModel) {
        self.data = data
        
        self.addSubview(self.elevatedView)
        self.elevatedView.addSubviews([self.titleLabel, self.newsImageView, self.leftSubtitleLabel, self.centerSubtitleLabel, self.rightSubtitleLabel])
        
        if let url = URL(string: "https://www.pomisna.info/uk/wp-json/wp/v2/media/\(data.featured_media!)") {
            self.newsImageView.loadNewsImage(url: url, size: .medium, index: newsImageView.tag)
        }
        
        if let isoDate = data.date {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ua_UA") // set locale to reliable US_POSIX
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            if let date = dateFormatter.date(from:isoDate) {
                dateFormatter.dateFormat = "dd.MM.yyyy"
                self.leftSubtitleLabel.setValue(dateFormatter.string(from: date), size: 12, lineHeight: 1.4, fontWeight: .regular, numberOfLines: 1, color: .lightGrayCustom)
//                dateFormatter.dateFormat = "HH:mm"
//                self.leftSubtitleLabel.text?.append("      \(dateFormatter.string(from: date))")
            }
        }
        
        //        if _ = data.notice {
        //            self.rightSubtitleLabel.setValue("Важливо!", size: 12, lineHeight: 1.4, fontWeight: .regular, numberOfLines: 1, color: .red, textAlignment: .right)
        //        }
        
        if let title = data.title?.rendered?.htmlToString {
            self.titleLabel.setValue(title, size: 16, fontWeight: checkIfNewsRead(id: data.id) ? .regular : .bold, numberOfLines: 3, color: .black)
        }
        
        configureCell()
        setupLayout()
    }
    
//    func confgireWithData(title: String, imageUrl: String = "", leftSubtitle: String = "", centerSubtitle: String = "", rightSubtitle: String = "") {
//        self.addSubview(self.elevatedView)
//        self.elevatedView.addSubviews([self.titleLabel, self.newsImageView, self.leftSubtitleLabel, self.centerSubtitleLabel, self.rightSubtitleLabel])
//        if let url = URL(string: imageUrl) {
//            self.newsImageView.load(url: url)
//        }
//        
//        if let date = leftSubtitle.formatDate(from: .unformatted, to: .dayMonthYearHoursMinutesShort) {
//            self.leftSubtitleLabel.setValue(date, size: 12, lineHeight: 1.4, fontWeight: .regular, numberOfLines: 1, color: .lightGrayCustom)
//        }
//        
//        self.rightSubtitleLabel.setValue(rightSubtitle, size: 12, lineHeight: 1.4, fontWeight: .regular, numberOfLines: 1, color: .red, textAlignment: .right)
//        
//        self.titleLabel.setValue(title, size: 16, fontWeight: .bold, numberOfLines: 3, color: .black)
//        
//        configureCell()
//        setupLayout()
//    }
    
    private func configureCell() {
        self.selectionStyle = .none
    }
    
    private func setupLayout() {
        self.elevatedView.fillSuperview(padding: UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16))
        
        self.newsImageView.anchor(top: self.elevatedView.topAnchor, leading: self.elevatedView.leadingAnchor, bottom: self.elevatedView.bottomAnchor, padding: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 0), size: CGSize(width: 88, height: 88))
        
        self.leftSubtitleLabel.anchor(top: self.elevatedView.topAnchor, leading: self.newsImageView.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 0), size: CGSize(width: 0, height: 17))
        
        self.centerSubtitleLabel.anchor(top: self.elevatedView.topAnchor, leading: self.leftSubtitleLabel.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 8, bottom: 0, right: 0), size: CGSize(width: 0, height: 17))
        
        self.rightSubtitleLabel.anchor(top: self.elevatedView.topAnchor, leading: self.centerSubtitleLabel.trailingAnchor, trailing: self.elevatedView.trailingAnchor, padding: UIEdgeInsets(top: 16, left: 8, bottom: 0, right: 16), size: CGSize(width: 0, height: 17))
        
        self.titleLabel.anchor(top: self.leftSubtitleLabel.bottomAnchor, leading: self.newsImageView.trailingAnchor, bottom: self.elevatedView.bottomAnchor, trailing: self.elevatedView.trailingAnchor, padding: UIEdgeInsets(top: 8, left: 16, bottom: 16, right: 16))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsImageView.sd_cancelCurrentImageLoad()
        self.newsImageView.image = nil
    }
    
    private func checkIfNewsRead(id: Int) -> Bool {
        if let readNews = UserDefaults.standard.stringArray(forKey: "readNews") {
            if readNews.contains("\(id)") {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
}

extension String {
    
    func correctPath() -> String {
        if last == "/" {
            var string = self
            string.removeLast()
            
            return string
        } else {
            fatalError("cannot correctPath in \(self)")
        }
    }
    
}
