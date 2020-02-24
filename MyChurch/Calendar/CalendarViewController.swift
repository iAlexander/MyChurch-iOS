// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import UIKit
import Koyomi

class CalendarViewController: ViewController {
            
    var date = Date()
    let mainView = CalendarView()
    var chooseMonth = String()
        
    override func viewDidLoad() {
        super.viewDidLoad()
         ConfigView()
        setupNavBar()
    }
    
    func ConfigView() {
        self.view.addSubview(mainView)
        self.mainView.frame = self.view.bounds
        mainView.calendar.calendarDelegate = self
    }
    
    private func setupNavBar() {
        self.navigationItem.leftBarButtonItems = [backBarButtonItem]
        self.navigationItem.rightBarButtonItems = [forwardBarButtonItem]
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        super.backBarButtonItem.action = #selector(previousMonth)
        super.forwardBarButtonItem.action = #selector(nextMonth)
        checkDate()
    }
}

extension CalendarViewController {
    func checkDate() {
          switch  mainView.calendar.currentDateString().strstr(needle: "/", beforeNeedle: true) {
          case "1":    self.navigationItem.title = "Ciчень \(mainView.calendar.currentDateString().strstr(needle: "/", beforeNeedle: false) ?? "")";chooseMonth = "Ciчня"
          case "2":    self.navigationItem.title = "Лютий  \(mainView.calendar.currentDateString().strstr(needle: "/", beforeNeedle: false) ?? "")";chooseMonth = "Лютого"
          case "3":    self.navigationItem.title = "Березень \(mainView.calendar.currentDateString().strstr(needle: "/", beforeNeedle: false) ?? "")";chooseMonth = "Березеня"
          case "4":    self.navigationItem.title = "Квiтень \(mainView.calendar.currentDateString().strstr(needle: "/", beforeNeedle: false) ?? "")";chooseMonth = "Квiтня"
          case "5":    self.navigationItem.title = "Травень \(mainView.calendar.currentDateString().strstr(needle: "/", beforeNeedle: false) ?? "")";chooseMonth = "Травеня"
          case "6":   self.navigationItem.title = "Червень \(mainView.calendar.currentDateString().strstr(needle: "/", beforeNeedle: false) ?? "")";chooseMonth = "Червня"
          case "7":   self.navigationItem.title = "Липень \(mainView.calendar.currentDateString().strstr(needle: "/", beforeNeedle: false) ?? "")";chooseMonth = "Липня"
          case "8":    self.navigationItem.title = "Серпень \(mainView.calendar.currentDateString().strstr(needle: "/", beforeNeedle: false) ?? "")";chooseMonth = "Серпня"
          case "9":    self.navigationItem.title = "Вересень \(mainView.calendar.currentDateString().strstr(needle: "/", beforeNeedle: false) ?? "")";chooseMonth = "Вересня"
          case "10":    self.navigationItem.title = "Жовтень \(mainView.calendar.currentDateString().strstr(needle: "/", beforeNeedle: false) ?? "")";chooseMonth = "Жовтня"
          case "11":    self.navigationItem.title = "Листопад \(mainView.calendar.currentDateString().strstr(needle: "/", beforeNeedle: false) ?? "")";chooseMonth = "Листопада"
          case "12":    self.navigationItem.title = "Грудень \(mainView.calendar.currentDateString().strstr(needle: "/", beforeNeedle: false) ?? "")";chooseMonth = "Груденя"
          default: break
          }
      }

    
    @objc private func previousMonth(_ sender: UIButton!) {
        let currentDateString = mainView.calendar.currentDateString(withFormat: "MM/yyyy")
        let monthOnCalendar = Int(currentDateString.components(separatedBy: "/")[0])
        let yearOnCalendar = Int(currentDateString.components(separatedBy: "/")[1])
        
        let dateNow = Date()
        let calendar = Calendar.current
        let monthNow = Int(calendar.component(.month, from: dateNow))
        let yearNow = Int(calendar.component(.year, from: dateNow))
        
        if(monthNow == monthOnCalendar && yearNow == yearOnCalendar){
            return
        }
        let month: MonthType = .previous
        mainView.calendar.display(in: month)
         checkDate()
    }
    
    @objc private func nextMonth(_ sender: UIButton!) {
        let month: MonthType = .next
        mainView.calendar.display(in: month)
         checkDate()
    }
}


// MARK: - KoyomiDelegate -
extension CalendarViewController: KoyomiDelegate {
    
    func koyomi(_ koyomi: Koyomi, didSelect date: Date?, forItemAt indexPath: IndexPath) {
        var timeInterval = DateComponents()
        timeInterval.hour = 2
        let dateNew = Calendar.current.date(byAdding: timeInterval, to: date!)!
        var dateStr = dateNew.description
        dateStr = String(dateStr.dropFirst(8))
        dateStr = dateStr.strstr(needle: " ", beforeNeedle: true) ?? ""
        if dateStr.prefix(1) == "0" {
            dateStr = String(dateStr.dropFirst(1))
        }
        mainView.choosedDay.text = "\(dateStr) \(chooseMonth)"
    }
}

extension String {
    func strstr(needle: String, beforeNeedle: Bool = false) -> String? {
        guard let range = self.range(of: needle) else { return nil }
        if beforeNeedle {
            return self.substring(to: range.lowerBound)
        }
        return self.substring(from: range.upperBound)
    }
}
