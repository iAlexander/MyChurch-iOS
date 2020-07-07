// Sasha Loghozinsky -- alogozinsky@gmail.com \ lohozinsky.o@d2.digital -- 2020

import UIKit
import Koyomi
import VACalendar

class CalendarViewController: ViewController, UITableViewDelegate, UITableViewDataSource {
    
    var date = Date()
    let mainView = CalendarView()
    var chooseMonth = String()
    private let reuseIdentifierTableView = "CalendarCellTableView"
    var allHolidays = [HolidaysData]()
    var chooseHolidays =  [HolidaysData]()
    var timeInterval = DateComponents()
    var dateNew = Date()
    var weekDaysView = VAWeekDaysView()
    var monthNumber = Int()
    var datePointsArray =  [(Date, [VADaySupplementary])]()

    let defaultCalendar: Calendar = {
        var calendar = Calendar.current
        calendar.firstWeekday = 0
        calendar.timeZone = TimeZone(secondsFromGMT: 1000)!
        return calendar
    }()
    
    var calendarView: VACalendarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        getData()
        setupNavBar()
        calendarConfig()
    }
    
    //MARK: Work with API
    func getData() {
        getHolidays() { (result) in
            switch result {
            case .success(let data):
                self.allHolidays = data.data?.list ?? [HolidaysData]()
                var holidayDates = [String]()
                
                for (index, item) in self.allHolidays.enumerated() {
                    self.allHolidays[index].dateNewStyle = item.dateNewStyle?.strstr(needle: "T", beforeNeedle: true) ?? ""
                    if item.priority == nil {
                    holidayDates.append(item.dateNewStyle ?? "")
                    }
                }
                
                for dateStr in holidayDates {
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                    let date = dateFormatter.date(from:dateStr)!
                    self.timeInterval.hour = 3
                    let dateNew = Calendar.current.date(byAdding: self.timeInterval, to: date)!
                    self.datePointsArray.append((dateNew.addingTimeInterval(TimeInterval((0 * 0 * 0))), [VADaySupplementary.bottomDots([.red])]))
                }
                
                self.calendarView.setSupplementaries(self.datePointsArray)
                UserDefaults.standard.set(holidayDates, forKey: "AllHolidays")
                //внизу код как по нажатию на ячейку календаря, чтоб сегодня сортирнуть дату и показать ее сразу
                self.reloadTableView(date: Date())
            case .partialSuccess( _): break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
          super.viewDidLayoutSubviews()
        
        if calendarView.frame == .zero {
              calendarView.frame = CGRect(
                  x: 0,
                  y: weekDaysView.frame.maxY,
                  width: view.frame.width,
                  height: view.frame.height * 0.5
              )
              calendarView.setup()
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
        vc.detailHolidayInfo = chooseHolidays[indexPath.row]
        if !(chooseHolidays[indexPath.row].iconImage?.name?.isEmpty ?? true) {
            vc.imageUrlString = "http://test.cerkva.asp-win.d2.digital/\(chooseHolidays[indexPath.row].iconImage?.path ?? "")/\(chooseHolidays[indexPath.row].iconImage?.name ?? "")"
        }
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func reloadTableView(date: Date) {
           self.timeInterval.hour = 3
           dateNew = Calendar.current.date(byAdding: self.timeInterval, to: date)!
           var dateStr = dateNew.description
           dateStr = String(dateStr.dropFirst(8))
           dateStr = dateStr.strstr(needle: " ", beforeNeedle: true) ?? ""
           if dateStr.prefix(1) == "0" {
               dateStr = String(dateStr.dropFirst(1))
           }
           self.mainView.choosedDay.text = "\(dateStr) \(self.chooseMonth)"
           let chooseDate = dateNew.description.strstr(needle: " ", beforeNeedle: true) ?? ""
           for item in self.allHolidays {
               if item.dateNewStyle == chooseDate {
                   self.chooseHolidays.append(item)
               }
           }
           self.mainView.holidayTableView.reloadData()
       }
}

extension CalendarViewController {
    func configView() {
        self.view.addSubview(mainView)
        self.mainView.frame = self.view.bounds
       // mainView.calendar.calendarDelegate = self
        mainView.holidayTableView.delegate = self
        mainView.holidayTableView.dataSource = self
        mainView.holidayTableView.register(CalendarTableCell.self, forCellReuseIdentifier: reuseIdentifierTableView)
        mainView.holidayTableView.separatorColor = .clear
    }
    
    func calendarConfig() {
        let calendar = VACalendar(calendar: defaultCalendar)
        calendarView = VACalendarView(frame: .zero, calendar: calendar)
        calendarView.showDaysOut = false
        calendarView.selectionStyle = .single
        calendarView.dayViewAppearanceDelegate = self
        calendarView.monthViewAppearanceDelegate = self
        calendarView.calendarDelegate = self
        calendarView.scrollDirection = .horizontal
        calendarView.isScrollEnabled = false
        
        let appereance = VAWeekDaysViewAppearance(symbolsType: .short, weekDayTextColor: .black, separatorBackgroundColor: UIColor.clear, calendar: defaultCalendar)
        weekDaysView.appearance = appereance
        calendarView.setSupplementaries(self.datePointsArray)
        weekDaysView.frame = CGRect(x: 0, y: 0, width:  view.frame.width, height: 50)
        view.addSubview(weekDaysView)
        view.addSubview(calendarView)
        let date = Date()
        writeDateStr(date: date)
    }
    
    func writeDateStr(date: Date) {
        let monthString = date.month
        switch monthString {
        case "January":    self.navigationItem.title = "Ciчень"; self.monthNumber = 1; self.chooseMonth = "Сiчня"
        case "February":    self.navigationItem.title = "Лютий "; self.monthNumber = 2; self.chooseMonth = "Лютого"
        case "March":    self.navigationItem.title = "Березень"; self.monthNumber = 3; self.chooseMonth = "Березня"
        case "April":    self.navigationItem.title = "Квiтень"; self.monthNumber = 4; self.chooseMonth = "Квiтня"
        case "May":    self.navigationItem.title = "Травень"; self.monthNumber = 5; self.chooseMonth = "Травня"
        case "June":   self.navigationItem.title = "Червень"; self.monthNumber = 6; self.chooseMonth = "Червня"
        case "July":   self.navigationItem.title = "Липень"; self.monthNumber = 7; self.chooseMonth = "Липня"
        case "August":    self.navigationItem.title = "Серпень"; self.monthNumber = 8; self.chooseMonth = "Серпня"
        case "September":    self.navigationItem.title = "Вересень"; self.monthNumber = 9; self.chooseMonth = "Вересня"
        case "October":    self.navigationItem.title = "Жовтень"; self.monthNumber = 10; self.chooseMonth = "Жовтня"
        case "November":    self.navigationItem.title = "Листопад"; self.monthNumber = 11; self.chooseMonth = "Листопада"
        case "December":    self.navigationItem.title = "Грудень"; self.monthNumber = 12; self.chooseMonth = "Грудня"
        default: break
        }
    }
    
    private func setupNavBar() {
        self.navigationItem.leftBarButtonItems = [backBarButtonItem]
        self.navigationItem.rightBarButtonItems = [forwardBarButtonItem]
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        super.backBarButtonItem.action = #selector(previousMonth)
        super.forwardBarButtonItem.action = #selector(nextMonth)
    }
    
    func checkMonthNum() {
        if  self.monthNumber > 12 {
            self.monthNumber = 1
        }
        if  self.monthNumber < 1 {
            self.monthNumber = 12
        }
        switch   self.monthNumber {
        case 1:   self.navigationItem.title = "Ciчень"
        case 2:   self.navigationItem.title = "Лютий "
        case 3 :  self.navigationItem.title = "Березень"
        case 4:   self.navigationItem.title = "Квiтень"
        case 5:   self.navigationItem.title = "Травень"
        case 6:   self.navigationItem.title = "Червень"
        case 7:   self.navigationItem.title = "Липень"
        case 8:    self.navigationItem.title = "Серпень"
        case 9:    self.navigationItem.title = "Вересень"
        case 10:   self.navigationItem.title = "Жовтень"
        case 11:    self.navigationItem.title = "Листопад"
        case 12:   self.navigationItem.title = "Грудень"
        default: break
        }
    }
    
    @objc private func previousMonth(_ sender: UIButton!) {
        calendarView.previousMonth()
        self.monthNumber -= 1
       checkMonthNum()
    }
    
    @objc private func nextMonth(_ sender: UIButton!) {
        calendarView.nextMonth()
        self.monthNumber += 1
        checkMonthNum()
    }
}


extension CalendarViewController: VAMonthViewAppearanceDelegate {
    func leftInset() -> CGFloat {
        return 10.0
    }
    
    func rightInset() -> CGFloat {
        return 10.0
    }
    
    func verticalMonthTitleFont() -> UIFont {
        return UIFont.systemFont(ofSize: 16, weight: .semibold)
    }
    
    func verticalMonthTitleColor() -> UIColor {
        return .black
    }
    
    func verticalCurrentMonthTitleColor() -> UIColor {
        return .red
    }
}

extension CalendarViewController: VADayViewAppearanceDelegate {
    
    func textColor(for state: VADayState) -> UIColor {
        switch state {
        case .out:
            return UIColor(red: 214 / 255, green: 214 / 255, blue: 219 / 255, alpha: 1.0)
        case .selected:
            return .white
        case .unavailable:
            return .lightGray
        default:
            return .black
        }
    }
    
    func textBackgroundColor(for state: VADayState) -> UIColor {
        switch state {
        case .selected:
            return .red
        default:
            return .clear
        }
    }
    
    func shape() -> VADayShape {
        return .circle
    }
    
    func dotBottomVerticalOffset(for state: VADayState) -> CGFloat {
        switch state {
        case .selected:
            return 2
        default:
            return -7
        }
    }
}

extension CalendarViewController: VACalendarViewDelegate {
    func selectedDate(_ date: Date) {
        chooseHolidays.removeAll()
        writeDateStr(date: date)
        self.reloadTableView(date: date)
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

extension Date {
    var month: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: self)
    }
}
