// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import Foundation

extension String {
    
    func trim() -> String {
        let trimmedString = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return trimmedString
    }
    
    func formatDate(from: DateFormat, to: DateFormat) -> String? {
        let dateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = from.rawValue
            dateFormatter.locale = Locale(identifier: Localization.uk.rawValue)
            
            return dateFormatter
        }()
        
        let dateObj = dateFormatter.date(from: self)
        
        dateFormatter.dateFormat = to.rawValue
        
        var result = self
        
        if let dateObj = dateObj {
            result = dateFormatter.string(from: dateObj)
        } else { return nil }
        
        return result
    }

    mutating func formatDate(format: DateFormat) -> Date? {
        let dateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format.rawValue
            dateFormatter.locale = Locale(identifier: Localization.uk.rawValue)
            
            return dateFormatter
        }()
        
        let dateObj = dateFormatter.date(from: self)
        return dateObj
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        
        do {
            return try NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
}
