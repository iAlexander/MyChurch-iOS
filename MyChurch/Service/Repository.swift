// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import Foundation

class Repository {
    
    static let shared = Repository()
    
    // MARK: - Temples
    func getTemples(lt: String, lg: String, completion: @escaping (TemplesData) -> Void) {
        APIService.shared.getTemples(lt: lt, lg: lg) { (response) in
            completion(response)
        }
    }

    // MARK: - Calendar
//    func getCalendar(completion: @escaping (CalendarResponse) -> Void) {
//        APIService.shared.getCalendar() { (response) in
//            completion(response)
//        }
//    }
    
    // MARK: - News
    func getNews(completion: @escaping (NewsResponse) -> Void) {
        APIService.shared.getNews { (response) in
            completion(response)
        }
    }
    
    // MARK: - Prayer
    func getPrayer(title: String?, type: String?, skip: Int, length: Int, completion: @escaping (PrayerResponse) -> Void) {
        APIService.shared.getPrayer(title: title, type: type, skip: skip, length: length) { (response) in
            completion(response)
        }
    }
    
    func getPrayer(completion: @escaping (PrayerResponse) -> Void) {
        APIService.shared.getPrayer() { (response) in
            completion(response)
        }
    }
    
}
