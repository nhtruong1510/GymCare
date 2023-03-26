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
    var isEditData: Bool = false
    private var listSchedules: Bool = false
    private let viewModel = ProgramViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    private func configUI() {
//        titleLabel.text = titleValue
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
        return listSearchData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ProgramViewCell.dequeueReuse(tableView: tableView)
        cell.fillData(data: listSearchData[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isEditData {
            viewModel.callApiGetClass(classId: castToInt(listSearchData[indexPath.row].id)) { data, msg in
                if let msg = msg {
                    AlertVC.show(viewController: self, msg: msg)
                } else {
                    if let data = data, castToInt(data.classes?.count) > 0 {
                        let vc = BookingVC()
                        self.listAddress[indexPath.row].addressClass = data.classes?[0]
                        vc.address = self.listAddress[indexPath.row]
                        vc.schedule = self.listSchedule[indexPath.row]
                        self.nextScreen(ctrl: vc)
                    }
                }
                
            }
        } else {
            let vc = ContentProgramVC()
            vc.classModel = listSearchData[indexPath.row]
            self.nextScreen(ctrl: vc)
        }
    }

}
