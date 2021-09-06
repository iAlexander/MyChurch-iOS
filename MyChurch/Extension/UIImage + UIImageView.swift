// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import UIKit
import AlamofireImage
import SDWebImage

enum ImageExtension: String {
    case png
    case jpeg
    case tiff
    case gif
    case ico
    case bmp
    case xbmp = "x-bmp"
    case xxbitmap = "x-xbitmap"
    case xwinbitmap = "x-win-bitmap"
}

extension UIImage {
    
    func getImage(resource resourceName: String, withExtension imageExtension: ImageExtension) {
        let url = Bundle.main.url(forResource: resourceName, withExtension: imageExtension.rawValue)!
        let data = try! Data(contentsOf: url)
        let image = UIImage(data: data, scale: UIScreen.main.scale)!

        image.af_inflate()
    }
    
}

fileprivate let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    enum ImageSize {
        case medium
        case full
    }

    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            if let cachedImage = imageCache.object(forKey: NSString(string: url.absoluteString)) {
                DispatchQueue.main.async {
                    self.image = cachedImage
                }
                return
            }
            var activityIndicator: UIActivityIndicatorView?
            DispatchQueue.main.async {
                activityIndicator = UIActivityIndicatorView(style: .gray)
                if let activityIndicator = activityIndicator {
                    self.addSubview(activityIndicator)
                    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
                    activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
                    activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
                    activityIndicator.startAnimating()
                }
            }
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        if let activityIndicator = activityIndicator {
                            activityIndicator.stopAnimating()
                        }
                        imageCache.setObject(image, forKey: NSString(string: url.absoluteString))
                        self.image = image
                    }
                }
            }
        }
    }
    
    func loadNewsImage(url: URL, size: ImageSize) {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            if let image = SDImageCache.shared.imageFromCache(forKey: url.absoluteString + (size == .medium ? "medium" : "full")) {
                DispatchQueue.main.async {
                    self.image = image
                }
                return
            }
            var activityIndicator: UIActivityIndicatorView?
            DispatchQueue.main.async {
                activityIndicator = UIActivityIndicatorView(style: .gray)
                if let activityIndicator = activityIndicator {
                    self.addSubview(activityIndicator)
                    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
                    activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
                    activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
                    activityIndicator.startAnimating()
                }
            }

            var request = URLRequest(url: url)
            let username = "mobileapp"
            let password = "i69UvVrJAhCce13"
            let loginString = String(format: "%@:%@", username, password)
            let loginData = loginString.data(using: String.Encoding.utf8)!
            let base64LoginString = loginData.base64EncodedString()
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                if let data = data {
                    if let imageResponse = try? JSONDecoder().decode(NewsWordPressImageModel.self, from: data) {
                        let urlString = (size == .medium ? imageResponse.media_details.sizes.medium.source_url : imageResponse.media_details.sizes.full.source_url)
                        if let imageUrl = URL(string: urlString) {
                            self.sd_setImage(with: imageUrl) { image, _, _, _ in
                                DispatchQueue.main.async {
                                    if let activityIndicator = activityIndicator {
                                        activityIndicator.stopAnimating()
                                    }
                                }
                                if let image = image {
                                    SDImageCache.shared.store(image, forKey: url.absoluteString + (size == .medium ? "medium" : "full"), toDisk: false, completion: nil)
                                }
                            }
//                            if let data = try? Data(contentsOf: url) {
//                                if let image = UIImage(data: data) {
//                                    DispatchQueue.main.async {
//                                        if let activityIndicator = activityIndicator {
//                                            activityIndicator.stopAnimating()
//                                        }
//                                        imageCache.setObject(image, forKey: NSString(string: url.absoluteString))
//                                        self.image = image
//                                    }
//                                }
//                            }
                        }
                    }
                }
            }.resume()
        }
    }
}
