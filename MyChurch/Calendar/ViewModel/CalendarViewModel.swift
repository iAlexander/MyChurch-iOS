// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import UIKit

protocol CalendarDelegate: class {
    func didFinishFathingData()
}

class CalendarViewModel: ViewModel {
    
    convenience init(delegate: CalendarDelegate) {
        self.init()
        
        self.delegate = delegate
    }

    weak var delegate: CalendarDelegate?
    
    static var calendar: [CalendarData]?
    
    func startFetchingData() {
        DispatchQueue.global(qos: .background).async {
            Repository.shared.getCalendar { (response) in
                CalendarViewModel.calendar = response.data
                
                DispatchQueue.main.async {
                    self.delegate?.didFinishFathingData()
                }
            }
        }
    }
    
}
