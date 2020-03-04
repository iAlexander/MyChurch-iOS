// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import Foundation

protocol PrayerDelegate: class {
    func didFinishFetchingData()
}

class PrayerViewModel: ViewModel {
    
    init(delegate: PrayerDelegate) {
        self.delegate  = delegate
    }
    
    weak var delegate: PrayerDelegate?
    
    static var prayers: [String : [Prayer]]?
    
    func startFetchingData() {
        DispatchQueue.global(qos: .background).async {
            Repository.shared.getPrayer(title: nil, type: nil, skip: 0, length: 100) { (response) in
                if let data = response.data {
                    PrayerViewModel.prayers = Dictionary(grouping: data, by: { ($0.type ?? "") })
                }
                
                DispatchQueue.main.async {
                    self.delegate?.didFinishFetchingData()
                }
            }
        }
    }
    
}
