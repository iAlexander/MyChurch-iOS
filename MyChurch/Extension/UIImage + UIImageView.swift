// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import UIKit
import AlamofireImage

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
}
