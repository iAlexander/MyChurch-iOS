// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import Foundation
import SwiftSoup

protocol NewsDetailsDelegate: class {
    func didParsingHTML(_ data: [Element])
}

class NewsDetailsViewModel: ViewModel {
    
    init(delegate: NewsDetailsDelegate) {
        self.delegate = delegate
    }
    
    weak var delegate: NewsDetailsDelegate?
    
    func format(_ html: String) -> String {
        let result = html.replacingOccurrences(of: "<p style=\"line-height: 16.2px;\">", with: "<p style=\"font-size: 20;line-height: 16.2px;\">").replacingOccurrences(of: "<p>", with: "<p style=\"font-size: 20;line-height: 16.2px;\">").replacingOccurrences(of: "(?i)\\{[^\\}]+\\}[^\\}]+\\}",with: "", options: .regularExpression).replacingOccurrences(of: "(?i){gallery}\\s*{/gallery}", with: "", options: .regularExpression)
        
        //        let result =  html.replacingOccurrences(of:"\\{[^\\}]+\\}", with: "", options: .regularExpression, range: nil)
        
        //        let result = html.replacingOccurrences(of: "(?i){gallery\\b[^{]*}\\s*{/gallery}", with: "", options: .regularExpression)
        
        return result
    }
    
}
