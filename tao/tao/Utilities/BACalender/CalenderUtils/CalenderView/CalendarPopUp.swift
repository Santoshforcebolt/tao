//
//  CalendarPopUp.swift
//  BACalender
//
//  Created by Betto Akkara on 20/10/20.
//  Copyright © 2020 Betto Akkara. All rights reserved.
//

import UIKit

public protocol CalendarPopUpDelegate: class {
    func dateChaged(date: Date)
}

public var BACalenderBundle = Bundle(for: CalendarPopUp.self)
public let BACalenderView = BACalenderBundle.loadNibNamed("CalendarPopUp", owner: nil, options: nil)?[0] as! CalendarPopUp
public class CalendarPopUp: UIView {
    
    
    public var themeColor : UIColor = UIColor.royal {
        didSet{
            yearview.backgroundColor = self.themeColor
            dateView.backgroundColor = self.themeColor
            dateLabels.forEach { (lbl) in
                lbl.textColor = self.themeColor
            }
            okbtn.setTitleColor(self.themeColor, for: .normal)
            cancelBtn.setTitleColor(self.themeColor, for: .normal)
            selectedRoundColor = self.themeColor
            todayColor = self.themeColor
        }
    }
    
    @IBOutlet weak var okbtn: UIButton!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet var dateLabels: [UILabel]!
    
    @IBOutlet weak var yearview: UIView!
    
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var calendarHeaderLabel: UILabel!
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var selectYear: UIButton!
    
    weak public var calendarDelegate: CalendarPopUpDelegate?
    
    let calLanguage: CalendarLanguage = .english
    private var endDate: Date!
    private var endRefDate: Date!
    private var startDate: Date!
    private var tableView = UITableView()
    private var federalCalendar = Calendar(identifier: .gregorian)
    private var yearsList : [Date] = []
    private var isCustomYearsList : Bool = false
    public var selectedDate: Date! = Date() {
        didSet {
            setDate()
        }
    }
    public var selected:Date = Date() {
        didSet {
            
            DispatchQueue.main.async {
                self.calendarView.scrollToDate(self.selected){
                    self.calendarView.selectDates([self.selected])
                }
            }
            
        }
    }
    
    public func configureCalender(
        startDate: Date =  CalendarPopUp.getYearBegining( Helper.calendarAdvanced(byAdding: .era, value: -1, startDate: Date())),
        endDate: Date = CalendarPopUp.getYearBegining( Helper.calendarAdvanced(byAdding: .era, value: 1, startDate: Date())),
        selectedDate : Date = Date())
    {
        self.startDate = startDate
        self.endDate = endDate
        self.selectedDate = startDate.endOfDay
        self.selected = startDate
        endRefDate = endDate
        setCalendar()
        setDate()
        
        let cornerRadius = CGFloat(10.0)
        let shadowOpacity = Float(1)
        self.layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.masksToBounds = false
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 5)
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
        
        delay(0.2, completion: {
            self.calendarView.scrollToDate(selectedDate)
            self.calendarView.visibleDates {[unowned self] (visibleDates: DateSegmentInfo) in
                self.setupViewsOfCalendar(from: visibleDates, selectedDate: selectedDate)
            }
        })
    }
    func confgYears(calenderStartDate : Date = Date(), previousYears : Int? = nil, futureYears : Int? = nil){
        var count = 0
        var startYear : Date = Date()
        var endYear : Date = Date()
        if previousYears == nil && futureYears == nil{
            startYear = calenderStartDate
            endYear = self.endDate
            count = Helper().yearsBetween(start: startYear, end: endYear)
        }else if previousYears == nil && futureYears != nil{
            startYear = calenderStartDate
            endYear = Helper.calendarAdvanced(byAdding: .year, value: (futureYears!), startDate: calenderStartDate)
            count = Helper().yearsBetween(start: startYear, end: endYear)
        }
        else if previousYears != nil && futureYears == nil{
            startYear = Helper.calendarAdvanced(byAdding: .year, value: -(previousYears!), startDate: calenderStartDate)
            endYear = self.endDate
            count = Helper().yearsBetween(start: startYear, end: endYear)
        }
        else{
            startYear = Helper.calendarAdvanced(byAdding: .year, value: -(previousYears!), startDate: calenderStartDate)
            endYear = Helper.calendarAdvanced(byAdding: .year, value: (futureYears!), startDate: calenderStartDate)
            count = Helper().yearsBetween(start: startYear, end: endYear)
        }
        
        self.yearsList.removeAll()
        for yearIndex in 0...count{
            yearsList.append(Helper.calendarAdvanced(byAdding: .year, value: yearIndex, startDate: startYear))
        }
        
    }
    
    @IBAction func selectYearBtn(_ sender: Any) {
        setYearListView()
    }
    /// Last Month End - Dec - 31
    class func getYearEnd(_ date : Date) -> Date{
        // Get the current year
        let year = Calendar.current.component(.year, from: date)
        // Get the first day of next year
        if let firstOfNextYear = Calendar.current.date(from: DateComponents(year: year + 1, month: 1, day: 1)) {
            // Get the last day of the current year
            let lastOfYear = Calendar.current.date(byAdding: .day, value: -1, to: firstOfNextYear)
            return lastOfYear!
        }else{
            return date
        }
    }
    /// Year Begning - Jan 1
    public  class func getYearBegining(_ date : Date) -> Date{
        // Get the current year
        let year = Calendar.current.component(.year, from: date)
        // Get the first day of next year
        if let firstOfYear = Calendar.current.date(from: DateComponents(year: year, month: 1, day: 1)) {

            return firstOfYear
        }else{
            return date
        }
    }
    
    override open func awakeFromNib() {
        
    }
    
    public func setDate() {
        let month = federalCalendar.dateComponents([.month], from: selectedDate).month!
        let weekday = federalCalendar.component(.weekday, from: selectedDate)
        
        let monthName = GetHumanDate(month: month, language: calLanguage)
        let week = GetWeekByLang(weekDay: weekday, language: calLanguage)
        
        let day = federalCalendar.component(.day, from: selectedDate)
        
        dateLabel.text = "\(week), " + monthName + " " + String(day)
    }
    
    public func setupViewsOfCalendar(from visibleDates: DateSegmentInfo, selectedDate : Date? = nil) {
        guard let startDateTemp = visibleDates.monthDates.first?.date else {
            return
        }
        var startDate = startDateTemp
        if selectedDate == nil{
            
            if startDate < self.startDate{
                startDate = self.startDate
            }
            if startDate > self.endDate{
                startDate = self.endDate
            }
            
        }else{
            
            startDate = selectedDate!
            if startDate < self.startDate{
                startDate = self.startDate
            }
            if startDate > self.endDate{
                startDate = self.endDate
            }
            
        }
        self.calendarView.selectDates([startDate])
        
        let month = federalCalendar.dateComponents([.month], from: startDate).month!
        let monthName = GetHumanDate(month: month, language: calLanguage)
        let weekday = federalCalendar.component(.weekday, from: startDate)
        let week = GetWeekByLang(weekDay: weekday, language: calLanguage)
        let year = federalCalendar.component(.year, from: startDate)
        let day = federalCalendar.component(.day, from: startDate)
        dateLabel.text = "\(week), " + monthName + " " + String(day)
        calendarHeaderLabel.text = String(year)
    }
    
    func setCalendar() {
        calendarView.calendarDataSource = self
        calendarView.calendarDelegate = self
        let nibName = UINib(nibName: "CellView", bundle: BACalenderBundle)
        calendarView.register(nibName, forCellWithReuseIdentifier: "CellView")
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
    }
    
}

// MARK : JTAppleCalendarDelegate
extension CalendarPopUp: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
    
    public func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        
        let parameters = ConfigurationParameters(startDate: startDate,
                                                 endDate: endDate,
                                                 numberOfRows: 6,
                                                 calendar: federalCalendar,
                                                 generateInDates: .forAllMonths,
                                                 generateOutDates: .tillEndOfGrid,
                                                 firstDayOfWeek: DaysOfWeek.sunday)
        
        return parameters
    }
    
    public func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        (cell as? CellView)?.handleCellSelection(cellState: cellState, date: date, selectedDate: selectedDate)
        if (Helper.calendarAdvanced(byAdding: .day, value: -1, startDate: self.startDate) >= date) || (date > self.endDate){
            (cell as? CellView)?.isUserInteractionEnabled = false
            (cell as? CellView)?.dayLabel.textColor = #colorLiteral(red: 0.8553319573, green: 0.8554759622, blue: 0.8553130031, alpha: 1)
        }
    }
    
    public func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let myCustomCell = calendar.dequeueReusableCell(withReuseIdentifier: "CellView", for: indexPath) as! CellView
        myCustomCell.handleCellSelection(cellState: cellState, date: date, selectedDate: selectedDate)
        if (Helper.calendarAdvanced(byAdding: .day, value: -1, startDate: self.startDate) >= date) || (date > self.endDate){
            myCustomCell.isUserInteractionEnabled = false
            myCustomCell.dayLabel.textColor = #colorLiteral(red: 0.8553319573, green: 0.8554759622, blue: 0.8553130031, alpha: 1)
        }
        return myCustomCell
    }
    
    public func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        selectedDate = date.endOfDay
        (cell as? CellView)?.cellSelectionChanged(cellState, date: date)
    }
    
    public func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        (cell as? CellView)?.cellSelectionChanged(cellState, date: date)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willResetCell cell: JTAppleCell) {
        (cell as? CellView)?.selectedView.isHidden = true
    }
    
    public func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        guard let startDate = visibleDates.monthDates.first?.date else {
            return
        }
        let calendar = Calendar.current
        let year = federalCalendar.component(.year, from: startDate)
        let month = federalCalendar.dateComponents([.month], from: startDate).month!
        let day = calendar.dateComponents([.day], from: self.selectedDate).day
        
        self.endRefDate = Calendar.current.date(from: DateComponents(year: year, month: month, day: day))
        
        self.setupViewsOfCalendar(from: visibleDates, selectedDate: self.endRefDate)
        
    }
    
    @IBAction func closePopupButtonPressed(_ sender: AnyObject) {
        if let superView = self.superview as? PopupContainer {
            (superView ).close()
        }
    }
    
    @IBAction func GetDateOk(_ sender: Any) {
        calendarDelegate?.dateChaged(date: selectedDate)
        if let superView = self.superview as? PopupContainer {
            (superView ).close()
        }
    }
    
}


extension CalendarPopUp : UITableViewDelegate, UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yearsList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = String(federalCalendar.component(.year, from: yearsList[indexPath.row]))
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.textLabel?.textColor = UIColor.black
        let y1 = federalCalendar.component(.year, from: yearsList[indexPath.row])
        let y2 = federalCalendar.component(.year, from: self.selectedDate)
        
        if y1 == y2{
            cell.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            cell.textLabel?.textColor = self.themeColor
        }
        cell.selectionStyle = .none
        return cell
        
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.setSelectedYear(index: indexPath.row)
        self.tableView.removeFromSuperview()
    }
    
    func setYearListView(){
        
        self.tableView.frame = CGRect(x: self.bounds.minX , y: self.bounds.minY + 95, width: self.bounds.width, height: self.bounds.height - 95)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.delegate = self
        self.tableView.separatorStyle = .none
        self.tableView.dataSource = self
        if !isCustomYearsList{
            self.confgYears(calenderStartDate : self.startDate)
        }
        self.addSubview(self.tableView)
        self.tableView.reloadData()
        var selectedIndex = 0
        self.yearsList.enumerated().forEach { (index,date) in
            let y1 = federalCalendar.component(.year, from: date)
            let y2 = federalCalendar.component(.year, from: self.selectedDate)
            
            if y1 == y2{
                selectedIndex = index
            }
        }
        
        let indexPath = NSIndexPath(row: selectedIndex, section: 0)
        tableView.scrollToRow(at: indexPath as IndexPath, at: .middle, animated: true)
        
    }
    
    func setSelectedYear(index : Int = 0){
        
        let selectedYear = self.yearsList[index]
        
        selectedDate = selectedYear.endOfDay
        setDate()
        self.calendarView.scrollToDate(selectedDate)
        self.calendarView.visibleDates {[unowned self] (visibleDates: DateSegmentInfo) in
            self.setupViewsOfCalendar(from: visibleDates,selectedDate:  self.selectedDate)
        }
        self.calendarView.reloadData()
        
        calendarView.setNeedsLayout()
        
    }
}

