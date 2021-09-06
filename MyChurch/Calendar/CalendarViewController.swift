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
//    var datePointsArray =  [(Date, [VADaySupplementary])]()

    let defaultCalendar: Calendar = {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "uk_UA")
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
                UserDefaults.standard.set(try? PropertyListEncoder().encode(data), forKey:"UserCalendar") //сохранил в юзердефолтс календарь
                self.setDotsOnCalendar(item: self.allHolidays)
//                var holidayDates = [String]()
//                for (index, item) in self.allHolidays.enumerated() {
//                    self.allHolidays[index].dateNewStyle = item.dateNewStyle?.strstr(needle: "T", beforeNeedle: true) ?? ""
//                    if item.priority == nil {
//                    holidayDates.append(item.dateNewStyle ?? "")
//                    }
//                }
//                for dateStr in holidayDates {
//                    let dateFormatter = DateFormatter()
//                    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
//                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//                    let date = dateFormatter.date(from:dateStr)!
//                    self.timeInterval.hour = 3
//                    let dateNew = Calendar.current.date(byAdding: self.timeInterval, to: date)!
//                    self.datePointsArray.append((dateNew.addingTimeInterval(TimeInterval((0 * 0 * 0))), [VADaySupplementary.bottomDots([.red])]))
//                }
                
//                self.calendarView.setSupplementaries(self.datePointsArray)
//                UserDefaults.standard.set(holidayDates, forKey: "AllHolidays")
                //внизу код как по нажатию на ячейку календаря, чтоб сегодня сортирнуть дату и показать ее сразу
                self.reloadTableView(date: Date())
            case .partialSuccess( _): self.offlane()
            case .failure(let error): self.offlane()
            }
        }
    }
    
    func offlane() {
        if let data = UserDefaults.standard.value(forKey:"UserCalendar") as? Data {
            let userData = try? PropertyListDecoder().decode(HolidaysAllData.self, from: data)
            self.allHolidays = userData?.data?.list ?? [HolidaysData]()
            self.setDotsOnCalendar(item: self.allHolidays)
//            var holidayDates = [String]()
//            for (index, item) in self.allHolidays.enumerated() {
//                self.allHolidays[index].dateNewStyle = item.dateNewStyle?.strstr(needle: "T", beforeNeedle: true) ?? ""
//                if item.priority == nil {
//                    holidayDates.append(item.dateNewStyle ?? "")
//                }
//            }
//            for dateStr in holidayDates {
//                let dateFormatter = DateFormatter()
//                dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
//                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//                let date = dateFormatter.date(from:dateStr)!
//                self.timeInterval.hour = 3
//                let dateNew = Calendar.current.date(byAdding: self.timeInterval, to: date)!
//                self.datePointsArray.append((dateNew.addingTimeInterval(TimeInterval((0 * 0 * 0))), [VADaySupplementary.bottomDots([.red])]))
//            }
//            self.calendarView.setSupplementaries(self.datePointsArray)
//            UserDefaults.standard.set(holidayDates, forKey: "AllHolidays")
            //внизу код как по нажатию на ячейку календаря, чтоб сегодня сортирнуть дату и показать ее сразу
            self.reloadTableView(date: Date())
        }
    }
    
    private func setDotsOnCalendar(item: [HolidaysData]) {
        var redDotsDates = [String]()
        var violetDotsDates = [String]()
        var blackDotsDates = [String]()
        var datePointsArray =  [(Date, [VADaySupplementary])]()
        for (index, item) in self.allHolidays.enumerated() {
            self.allHolidays[index].dateNewStyle = item.dateNewStyle?.strstr(needle: "T", beforeNeedle: true) ?? ""
            switch item.group?.name {
            case "Червоний на 12 великих свят +- ще 10 свят":
                redDotsDates.append(item.dateNewStyle ?? "")
            case "Cуб та нд Великого посту":
                violetDotsDates.append(item.dateNewStyle ?? "")
            case "Пн-пт Великого посту":
                blackDotsDates.append(item.dateNewStyle ?? "")
            default:
                ()
            }
        }
        for dateStr in redDotsDates {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let date = dateFormatter.date(from:dateStr)!
            self.timeInterval.hour = 3
            let dateNew = Calendar.current.date(byAdding: self.timeInterval, to: date)!
            datePointsArray.append((dateNew.addingTimeInterval(TimeInterval((0 * 0 * 0))), [VADaySupplementary.bottomDots([UIColor(hexString: "#db0032")])]))
        }
        for dateStr in violetDotsDates {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let date = dateFormatter.date(from:dateStr)!
            self.timeInterval.hour = 3
            let dateNew = Calendar.current.date(byAdding: self.timeInterval, to: date)!
            datePointsArray.append((dateNew.addingTimeInterval(TimeInterval((0 * 0 * 0))), [VADaySupplementary.bottomDots([UIColor(hexString: "#8331a7")])]))
        }
        for dateStr in blackDotsDates {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let date = dateFormatter.date(from:dateStr)!
            self.timeInterval.hour = 3
            let dateNew = Calendar.current.date(byAdding: self.timeInterval, to: date)!
            datePointsArray.append((dateNew.addingTimeInterval(TimeInterval((0 * 0 * 0))), [VADaySupplementary.bottomDots([UIColor(hexString: "#212721")])]))
        }
        let holidayDates = redDotsDates + violetDotsDates + blackDotsDates
        UserDefaults.standard.set(holidayDates, forKey: "AllHolidays")
        self.calendarView.setSupplementaries(datePointsArray)
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
        if let color = chooseHolidays[indexPath.row].color {
            cell.goldenLine.backgroundColor = UIColor(hexString: color)
            cell.arrowImage.tintColor = UIColor(hexString: color)
        }
        cell.selectionStyle = .none
        cell.holidayName.text = chooseHolidays[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailHolidayViewController()
        vc.titleText = mainView.choosedDay.text ?? ""
        vc.detailHolidayInfo = chooseHolidays[indexPath.row]
        if !(chooseHolidays[indexPath.row].iconImage?.name?.isEmpty ?? true) {
            vc.imageUrlString = "https://mobile.pomisna.info/\(chooseHolidays[indexPath.row].iconImage?.path ?? "")/\(chooseHolidays[indexPath.row].iconImage?.name ?? "")"
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
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        let safeAreaBottom: CGFloat = window?.safeAreaInsets.bottom ?? 0.0
        let safeAreaTop: CGFloat = window?.safeAreaInsets.top ?? 0.0
        self.mainView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.frame.height - safeAreaTop - safeAreaBottom - 90)
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
        
        let appereance = VAWeekDaysViewAppearance(symbolsType: .short, weekDayTextColor: .black, weekDayTextFont: .systemFont(ofSize: 17, weight: .semibold), leftInset: 10, rightInset: 10, separatorBackgroundColor: .clear, calendar: defaultCalendar)
        weekDaysView.appearance = appereance
//        calendarView.setSupplementaries(self.datePointsArray)
        weekDaysView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        weekDaysView.subviews.forEach { view in
            if let label = view as? UILabel {
                if let text = label.text {
                    label.text = text.capitalizingFirstLetter()
                }
            }
        }
        mainView.addSubview(weekDaysView)
        mainView.addSubview(calendarView)
        let date = Date()
        writeDateStr(date: date)
    }
    
    func writeDateStr(date: Date) {
        let monthString = date.month
        switch monthString {
        case "січня":    self.navigationItem.title = "Ciчень"; self.monthNumber = 1; self.chooseMonth = "січня"
        case "лютого":    self.navigationItem.title = "Лютий "; self.monthNumber = 2; self.chooseMonth = "лютого"
        case "березня":    self.navigationItem.title = "Березень"; self.monthNumber = 3; self.chooseMonth = "березня"
        case "квітня":    self.navigationItem.title = "Квiтень"; self.monthNumber = 4; self.chooseMonth = "квітня"
        case "травня":    self.navigationItem.title = "Травень"; self.monthNumber = 5; self.chooseMonth = "травня"
        case "червня":   self.navigationItem.title = "Червень"; self.monthNumber = 6; self.chooseMonth = "червня"
        case "липня":   self.navigationItem.title = "Липень"; self.monthNumber = 7; self.chooseMonth = "липня"
        case "серпня":    self.navigationItem.title = "Серпень"; self.monthNumber = 8; self.chooseMonth = "серпня"
        case "вересня":    self.navigationItem.title = "Вересень"; self.monthNumber = 9; self.chooseMonth = "вересня"
        case "жовтня":    self.navigationItem.title = "Жовтень"; self.monthNumber = 10; self.chooseMonth = "жовтня"
        case "листопада":    self.navigationItem.title = "Листопад"; self.monthNumber = 11; self.chooseMonth = "листопада"
        case "грудня":    self.navigationItem.title = "Грудень"; self.monthNumber = 12; self.chooseMonth = "грудня"
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
            return UIColor(red: 0.004, green: 0.478, blue: 0.898, alpha: 0.9)
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
