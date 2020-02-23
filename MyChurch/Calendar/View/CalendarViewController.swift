// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import UIKit

class CalendarViewController: ViewController, CalendarDelegate {
    
//    fileprivate weak var calendar: FSCalendar!
    
    lazy var vm = CalendarViewModel(delegate: self)
    
    var date = Date()
    lazy var calendar = Calendar(identifier: .iso8601)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.vm.startFetchingData()
        
        setupNavBar()
    }
    
    private func setupNavBar() {
        self.navigationItem.leftBarButtonItems = [backBarButtonItem]
        self.navigationItem.rightBarButtonItems = [forwardBarButtonItem]
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        super.backBarButtonItem.action = #selector(previousMonth)
        super.forwardBarButtonItem.action = #selector(nextMonth)
        
        let monthIndex = calendar.component(.month, from: self.date)
        let month = returnMothName(indexOfMonth: monthIndex)
        changeNavigationTitle(month)
    }
    
}

extension CalendarViewController {
    
    func didFinishFathingData() {
        print(CalendarViewModel.calendar as Any)
    }
    
    func changeNavigationTitle(_ data: String) {
        self.navigationItem.title = data
    }
    
    func returnMothName(indexOfMonth: Int) -> String {
        switch indexOfMonth {
            case 1: return "Cічень"
            case 2: return "Лютий"
            case 3: return "Березень"
            case 4: return "Квітень"
            case 5: return "Травень"
            case 6: return "Червень"
            case 7: return "Липень"
            case 8: return "Серпень"
            case 9: return "Вересень"
            case 10: return "Жовтень"
            case 11: return "Листопад"
            default:
                return "Грудень"
        }
    }
    
    @objc private func previousMonth(_ sender: UIButton!) {
        print("previousMonth")
    }
    
    @objc private func nextMonth(_ sender: UIButton!) {
        print("nextMonth")
    }
    
}
