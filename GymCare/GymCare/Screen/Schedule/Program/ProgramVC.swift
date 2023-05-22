//
//  ProgramVC.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 25/02/2023.
//

import UIKit

class ProgramVC: BaseViewController {

    @IBOutlet private weak var tableView: UITableView!

    var titleValue: String?

    var listSearchData: [Class] = []
    var listAddress: [Address] = []
    var listSchedule: [Schedule] = []
    var listSchedules: [ScheduleModel] = []
    var isEditData: Bool = false
    var isEditData1: Bool = false

    private let viewModel = ProgramViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    private func configUI() {
        if let titleValue = titleValue {
            cutomNavi.title = titleValue
        }
        cutomNavi.onClickBack = { [weak self] in
            guard let `self` = self else { return }
            self.backScreen()
        }
        tableView.registerCells(from: .programViewCell)
        tableView.tableFooterView = UIView()
    }

}

extension ProgramVC: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isEditData {
            return viewModel.setListSchedule(listSchedule: listSchedule, listClass: listSearchData).count
        }
        return listSearchData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ProgramViewCell.dequeueReuse(tableView: tableView)
        if isEditData1 {
            cell.fillDataEdit1(data: listSchedule[indexPath.row])
        } else if isEditData {
            let listSchedules = viewModel.setListSchedule(listSchedule: listSchedule, listClass: listSearchData)
            cell.fillDataEdit(data: listSchedules[indexPath.row])
        } else {
            cell.fillData(data: listSearchData[indexPath.row])
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isEditData {
            let listSchedules = viewModel.setListSchedule(listSchedule: listSchedule, listClass: listSearchData)
            let listSchedule = listSchedules[indexPath.row]
            if castToInt(listSchedule.schedules?.count) == 1 {
                getClass(classId: castToInt(listSchedule.schedules?[0].scheduleClass?.id), index: indexPath.row, schedule: listSchedule.schedules?[0])
                return
            }
            let vc = ProgramVC()
            vc.titleValue = castToInt(listSchedule.schedules?.count) > 0 ? listSchedule.schedules?[0].scheduleClass?.name : nil
            vc.listSchedule = listSchedule.schedules ?? []
            vc.listSearchData = listSchedule.schedules?.compactMap({$0.scheduleClass}) ?? []
            vc.listAddress = listSchedule.schedules?.compactMap({$0.address}) ?? []
            vc.isEditData1 = true
            self.nextScreen(ctrl: vc)
        } else if isEditData1 {
            getClass(classId: castToInt(listSearchData[indexPath.row].id), index: indexPath.row)
        } else {
            let vc = ContentProgramVC()
            vc.classModel = listSearchData[indexPath.row]
            self.nextScreen(ctrl: vc)
        }
    }

    private func getClass(classId: Int, index: Int, schedule: Schedule? = nil) {
        viewModel.callApiGetClass(classId: classId) { data, msg in
            if let msg = msg {
                AlertVC.show(viewController: self, msg: msg)
            } else {
                if let data = data, castToInt(data.classes?.count) > 0 {
                    let vc = BookingVC1()
                    self.listAddress[index].addressClass = data.classes?[0]
                    vc.address = self.listAddress[index]
                    vc.schedule = self.listSchedule[index]
                    if let schedule = schedule {
                        schedule.address?.addressClass = data.classes?[0]
                        vc.address = schedule.address ?? Address()
                        vc.schedule = schedule
                    }
                    self.nextScreen(ctrl: vc)
                }
            }
        }
    }
}
