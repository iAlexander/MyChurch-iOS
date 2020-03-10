// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import UIKit
import Koyomi

class CalendarViewController: ViewController, UITableViewDelegate, UITableViewDataSource {
    
    var date = Date()
    let mainView = CalendarView()
    var chooseMonth = String()
    private let reuseIdentifierTableView = "CalendarCellTableView"
    var allHolidays = [HolidaysData]()
    var chooseHolidays =  [HolidaysData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        getData()
        setupNavBar()
    }
    
    //MARK: Work with API
    func getData() {
        getHolidays() { (result) in
            switch result {
            case .success(let data):
                self.allHolidays = data.data ?? [HolidaysData]()
                for (index, item) in self.allHolidays.enumerated() {
                    self.allHolidays[index].date = item.date?.strstr(needle: "T", beforeNeedle: true) ?? ""
                }
                
                self.mainView.holidayTableView.reloadData()
                self.mainView.calendar.reloadData()
            case .partialSuccess( _): break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //MARK: Work with tableView
    func  tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chooseHolidays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierTableView, for: indexPath) as! CalendarTableCell
        cell.selectionStyle = .none
        cell.holidayName.text = chooseHolidays[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailHolidayViewController()
        vc.titleText = mainView.choosedDay.text ?? ""
        vc.holidayId = chooseHolidays[indexPath.row].id ?? 0
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension CalendarViewController {
    
    func configView() {
        self.view.addSubview(mainView)
        self.mainView.frame = self.view.bounds
        mainView.calendar.calendarDelegate = self
        mainView.holidayTableView.delegate = self
        mainView.holidayTableView.dataSource = self
        mainView.holidayTableView.register(CalendarTableCell.self, forCellReuseIdentifier: reuseIdentifierTableView)
        mainView.holidayTableView.separatorColor = .clear
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
       
    func koyomi(_ koyomi: Koyomi, currentDateString dateString: String) {
        print(dateString)
    }
    
  
    
    func koyomi(_ koyomi: Koyomi, fontForItemAt indexPath: IndexPath, date: Date) -> UIFont? {
        let today = Date()
//        let dateStr = date.description.strstr(needle: " ", beforeNeedle: true) ?? ""
//
//            if item.date == dateStr {
//                //koyomi.needPoint = true
//                print(item)
//            } else {
//                print(item)
//             //   koyomi.needPoint = false
//            }
//        }
        return today == date ? UIFont(name:"FuturaStd-Bold", size:0) : nil
    }
    
    func koyomi(_ koyomi: Koyomi, didSelect date: Date?, forItemAt indexPath: IndexPath) {
        chooseHolidays.removeAll()
        var timeInterval = DateComponents()
        timeInterval.hour = 3
        let dateNew = Calendar.current.date(byAdding: timeInterval, to: date!)!
        var dateStr = dateNew.description
        dateStr = String(dateStr.dropFirst(8))
        dateStr = dateStr.strstr(needle: " ", beforeNeedle: true) ?? ""
        if dateStr.prefix(1) == "0" {
            dateStr = String(dateStr.dropFirst(1))
        }
        mainView.choosedDay.text = "\(dateStr) \(chooseMonth)"
        let chooseDate = dateNew.description.strstr(needle: " ", beforeNeedle: true) ?? ""
        
        for item in self.allHolidays {
            if item.date == chooseDate {
                chooseHolidays.append(item)
            }
        }
        mainView.holidayTableView.reloadData()
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
