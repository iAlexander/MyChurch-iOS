// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import Foundation

class Repository {
    
    static let shared = Repository()
    
    // Temples
    func getTemples(lt: String, lg: String, completion: @escaping (TemplesData) -> Void) {
        APIService.shared.getTemples(lt: lt, lg: lg) { (response) in
            completion(response)
        }
    }
    
    // Calendar
    func getCalendar(completion: @escaping (CalendarResponse) -> Void) {
        APIService.shared.getCalendar() { (response) in
            completion(response)
        }
    }
    
    // News
    func getNews(completion: @escaping (NewsResponse) -> Void) {
        APIService.shared.getNews { (response) in
            completion(response)
        }
    }
    
}
