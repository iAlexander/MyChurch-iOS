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

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func imageFromServerURL(_ URLString: String, placeHolder: UIImage?) {
        self.image = nil
        
        if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) {
            self.image = cachedImage
            return
        }
        
        if let url = URL(string: URLString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                //print("RESPONSE FROM API: \(response)")
                if error != nil {
                    DispatchQueue.main.async {
                        self.image = placeHolder
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                            self.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
    
}
