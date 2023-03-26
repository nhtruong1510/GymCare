//
//  ListPaymentVC.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 26/03/2023.
//

import UIKit

class ListPaymentVC: BaseViewController {

    @IBOutlet private weak var tableView: UITableView!

    private var listNotifi: [Payment] = []
    private let viewModel = ListPaymentViewModel()
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
        tableView.registerCells(from: .paymentViewCell)
        refreshControl.addTarget(self, action: #selector(getListNotify), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }

    @objc private func getListNotify() {
        viewModel.callApiGetPayment(customerId: castToInt(userInfo?.id)) { [weak self] result, error in
            guard let `self` = self else { return }
            if let error = error {
                AlertVC.show(viewController: self, msg: error)
                return
            }
            if let notifications = result?.payments {
                self.listNotifi = notifications.reversed()
            }
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }

    private func showDetail(noti: Payment, index: Int) {
        let notifyDetailVC = PaymentDetailVC()
        notifyDetailVC.param = noti
        self.nextScreen(ctrl: notifyDetailVC)
    }
}

extension ListPaymentVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listNotifi.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PaymentViewCell.dequeueReuse(tableView: tableView)
        guard indexPath.row < listNotifi.count else { return cell }
        let notify = listNotifi[indexPath.row]
        cell.fillData(notify: notify)
        cell.showDetail = { [unowned self] in
            self.showDetail(noti: notify, index: indexPath.row)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

}

