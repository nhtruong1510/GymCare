//
//  NotificationVC.swift
//  GymCareForTrainer
//
//  Created by Truong Nguyen Huu on 16/03/2023.
//

import UIKit
import SwiftUI

class NotificationVC: BaseViewController {

    @IBOutlet private weak var tableView: UITableView!

    private var listNotifi: [NotifiObject] = []
    private let viewModel = NotificationViewModel()
    private let refreshControl = UIRefreshControl()
    private let userInfo = ServiceSettings.shared.userInfo

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        getListNotify()
    }
    
    private func configUI() {
        cutomNavi.onClickBack = { [weak self] in
            guard let `self` = self else { return }
            self.backScreen()
        }
        tableView.registerCells(from: .notificationViewCell)
        refreshControl.addTarget(self, action: #selector(getListNotify), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }

    @objc private func getListNotify() {
        viewModel.callApiGetSchedule(customerId: castToInt(userInfo?.id)) { [weak self] result, error in
            guard let `self` = self else { return }
            if let error = error {
                AlertVC.show(viewController: self, msg: error)
                return
            }
            if let notifications = result?.notifications {
                self.listNotifi = notifications.reversed()
            }
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }

    private func showDetail(noti: NotifiObject, index: Int) {
        if noti.status == TypeStatus.acceptCreate.rawValue {
            let vc = PaymentVC1()
            let notify = listNotifi[index]
            let param = ScheduleParamObject(customer_id: castToInt(ServiceSettings.shared.userInfo?.id),
                                            address_id: castToInt(notify.address?.id),
                                            class_id: castToInt(notify.classModel?.id),
                                            trainer_id: castToInt(notify.trainer?.id),
                                            day: castToString(notify.day),
                                            start_date: castToString(notify.start_date),
                                            end_date: castToString(notify.end_date),
                                            time: castToString(notify.time),
                                            date_id: notify.date_id,
                                            time_id: notify.time_id,
                                            money: notify.money)
            vc.param = param
            vc.address = listNotifi[index].address ?? Address()
//            vc.classModel = listNotifi[index].classModel ?? ClassModel()
            nextScreen(ctrl: vc)
            return
        }
        let notifyDetailVC = NotifiDetailVC()
        notifyDetailVC.notify = noti
        self.nextScreen(ctrl: notifyDetailVC)
    }
}

extension NotificationVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listNotifi.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = NotificationViewCell.dequeueReuse(tableView: tableView)
        guard indexPath.row < listNotifi.count else { return cell }
        let notify = listNotifi[indexPath.row]
        cell.fillData(notify: notify)
        cell.showDetail = { [unowned self] in
            self.showDetail(noti: notify, index: indexPath.row)
            self.listNotifi[indexPath.row].is_read = 1
            self.viewModel.callApiUpdateStatus(notiId: castToInt(self.listNotifi[indexPath.row].id)) {}
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

}

// 3
struct NotificationVCRepresentation: UIViewControllerRepresentable {
    // 4
    typealias UIViewControllerType = NotificationVC
    
    // 5
    func makeUIViewController(context: Context) -> NotificationVC {
        NotificationVC()
    }
    
    // 6
    func updateUIViewController(_ uiViewController: NotificationVC, context: Context) {
        
    }
}
