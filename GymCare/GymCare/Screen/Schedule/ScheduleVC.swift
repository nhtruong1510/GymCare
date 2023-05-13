//
//  ScheduleVC.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 25/02/2023.
//

import UIKit
import SwiftUI
import JTAppleCalendar

class ScheduleVC: BaseViewController {
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var tableView: ContentSizedTableView!
    @IBOutlet private weak var calendarView: JTACMonthView!
    
    var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.DATE_PARAM_FORMAT
        return formatter
    }
    private var selectedDate = Date()
    private let viewModel = ScheduleViewModel()
    private let userInfo = ServiceSettings.shared.userInfo
    private var times: [Time] = []
    private var isInit: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isInit {
            getSchedule(showLoading: true)
            isInit = false
        } else {
            getSchedule(showLoading: false)
        }
    }
    
    private func configUI() {
        tableView.registerCells(from: .scheduleViewCell)
        calendarView.registerCells(from: .dateCell)
        calendarView.registerCellsFooterHeader(from: .dateHeader, ofKind: UICollectionView.elementKindSectionHeader)
        calendarView.scrollingMode   = .stopAtEachCalendarFrame
        self.calendarView.selectDates([ Date() ])
        times = viewModel.getAllTimeElement(date: self.selectedDate.toString(Constants.DATE_PARAM_FORMAT))
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
    }
    
    @objc private func refresh(_ sender: AnyObject) {
        getSchedule(showLoading: false)
    }
    
    func getSchedule(showLoading: Bool) {
        viewModel.callApiGetSchedule(showLoading: showLoading, customerId: castToInt(userInfo?.id)) { msg in
            if let msg = msg {
                AlertVC.show(viewController: self, msg: msg)
            } else {
                self.calendarView.reloadData()
                self.tableView.reloadData()
            }
            self.scrollView.refreshControl?.endRefreshing()
        }
    }
    
    func configureCell(view: JTACDayCell?, cellState: CellState) {
        guard let cell = view as? DateCell  else { return }
        cell.dateLabel.text = cellState.text
        handleCellTextColor(cell: cell, cellState: cellState)
        handleCellEvents(cell: cell, cellState: cellState)
    }
    
    func handleCellTextColor(cell: DateCell, cellState: CellState) {
        
        if cellState.isSelected {
            cell.containerView.backgroundColor = .main_color
            cell.dotView.backgroundColor = .white
            cell.dateLabel.textColor = .white
        } else {
            cell.containerView.backgroundColor = .clear
            cell.dotView.backgroundColor = .main_color
            cell.dateLabel.textColor = .black
        }
        if cellState.dateBelongsTo == .thisMonth {
            if cellState.isSelected {
                cell.dateLabel.textColor = .white
            } else {
                cell.dateLabel.textColor = cellState.day == .sunday ? .red : .black
            }
        } else {
            cell.dateLabel.textColor = UIColor.gray
        }
    }
    
    func handleCellEvents(cell: DateCell, cellState: CellState) {
        let dateString = formatter.string(from: cellState.date)
        let havePracticeDate = viewModel.dateElements.filter({ $0.date == dateString }).count
        if havePracticeDate == 0 {
            cell.dotView.isHidden = true
//            tableView.isHidden = true
        } else {
//            tableView.isHidden = false
            cell.dotView.isHidden = false
        }
    }
    
    @IBAction private func updateSchedule() {
        let vc = ProgramVC()
        vc.titleValue = "Các lớp đang tham gia"
        vc.listSearchData = viewModel.schedules?.compactMap({$0.scheduleClass}) ?? []
        vc.listAddress = viewModel.schedules?.compactMap({$0.address}) ?? []
        vc.listSchedule = viewModel.schedules ?? []

        vc.isEditData = true
        self.nextScreen(ctrl: vc)
    }
}

extension ScheduleVC: JTACMonthViewDataSource {
    func configureCalendar(_ calendar: JTACMonthView) -> ConfigurationParameters {
        let startDate = Date()
        let endDate = formatter.date(from: "2030-01-01")!
        return ConfigurationParameters(startDate: startDate, endDate: endDate)
    }
}

extension ScheduleVC: JTACMonthViewDelegate {
    func calendar(_ calendar: JTACMonthView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTACDayCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "DateCell", for: indexPath) as! DateCell
        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        return cell
    }
    
    func calendar(_ calendar: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        configureCell(view: cell, cellState: cellState)
    }
    
    
    func calendar(_ calendar: JTACMonthView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTACMonthReusableView {
        let formatter = DateFormatter()  // Declare this outside, to avoid instancing this heavy class multiple times.
        formatter.dateFormat = "MM, yyyy"
        
        let header = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: "DateHeader", for: indexPath) as! DateHeader
        header.monthTitle.text = "Tháng " + formatter.string(from: range.start)
        return header
    }

    func calendarSizeForMonths(_ calendar: JTACMonthView?) -> MonthSize? {
        return MonthSize(defaultSize: 100)
    }
    
    func calendar(_ calendar: JTACMonthView, didSelectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        configureCell(view: cell, cellState: cellState)
        self.selectedDate = date
        tableView.reloadData()
    }
    
    func calendar(_ calendar: JTACMonthView, didDeselectDate date: Date, cell: JTACDayCell?, cellState: CellState, indexPath: IndexPath) {
        configureCell(view: cell, cellState: cellState)
    }
}

extension ScheduleVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        times = viewModel.getAllTimeElement(date: self.selectedDate.toString(Constants.DATE_PARAM_FORMAT))
        return times.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ScheduleViewCell.dequeueReuse(tableView: tableView)
        cell.fillData(data: times[indexPath.row])
        cell.onClickCancel = { [weak self] in
            guard let `self` = self else { return }
            ConfirmVC.show(viewController: self, title: "Xác nhận", msg: "Bạn có chắc chắn thực hiện thao tác này?") {
                self.viewModel.callApiCancelSchedule(timeId: castToInt(self.times[indexPath.row].id)) { success, msg in
                    if success {
                        AlertVC.show(viewController: self, msg: msg) {
                            self.tableView.reloadData()
                        }
                    } else {
                        AlertVC.show(viewController: self, msg: msg)
                    }
                    
                }
            }
        }
        return cell
    }
}

// 3
struct ScheduleVCRepresentation: UIViewControllerRepresentable {
    // 4
    typealias UIViewControllerType = ScheduleVC
    
    // 5
    func makeUIViewController(context: Context) -> ScheduleVC {
        ScheduleVC()
    }
    
    // 6
    func updateUIViewController(_ uiViewController: ScheduleVC, context: Context) {
        
    }
}
