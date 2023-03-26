//
//  PaymentVC.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 24/02/2023.
//

import UIKit

class PaymentVC: BaseViewController {

    @IBOutlet private var avatarView: AvatarView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var addressLabel: UILabel!
    @IBOutlet private var dayLabel: UILabel!
    @IBOutlet private var timeLabel: UILabel!
    @IBOutlet private var expiredLabel: UILabel!
    @IBOutlet private var trainerLabel: UILabel!
    @IBOutlet private var trainerView: UIView!
    @IBOutlet private var amountLabel: UILabel!

    private let viewModel: PaymentViewModel = PaymentViewModel()

    var address = Address()
    var param = ScheduleParamObject()
    var trainer: Trainer?
    private let userInfo = ServiceSettings.shared.userInfo
    private var sumMoney: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        fillData()
    }

    private func configUI() {
        cutomNavi.onClickBack = { [weak self] in
            guard let `self` = self else { return }
            self.backScreen()
        }
    }
    
    private func fillData() {
        avatarView.setupAvatarView(avatar: userInfo?.avatar, gender: userInfo?.gender)
        nameLabel.text = userInfo?.name
        addressLabel.text = address.address
        dayLabel.text = param.day
        timeLabel.text = param.time
        if let trainer = trainer {
            trainerLabel.text = trainer.name
            trainerView.isHidden = false
        }
        let start_date = formatDateString(dateString: castToString(param.start_date), Constants.DATE_PARAM_FORMAT, Constants.DATE_FORMAT)
        let end_date = formatDateString(dateString: castToString(param.end_date), Constants.DATE_PARAM_FORMAT, Constants.DATE_FORMAT)
        expiredLabel.text = castToString(start_date) + " - " + castToString(end_date)
        if param.trainer_id != nil {
            let sumSession = viewModel.getSumSession(fromDate: castToString(start_date),
                                                   toDate: castToString(end_date),
                                                   day: castToString(param.day))
            sumMoney = castToInt(param.money) * sumSession
            amountLabel.text = castToString(param.money).formatMoney()  + "đ" + "*" + castToString(sumSession) + " buổi = " + castToString(sumMoney).formatMoney() + " VNĐ"
        } else {
            let sumMonth = viewModel.getSumMonth(fromDate: castToString(start_date),
                                                   toDate: castToString(end_date),
                                                   day: castToString(param.day))
            sumMoney = castToInt(param.money) * sumMonth
            amountLabel.text = castToString(param.money).formatMoney()  + "đ" + "*" + castToString(sumMonth) + " tháng = " + castToString(sumMoney).formatMoney() + " VNĐ"
        }
        param.money = sumMoney
//        param.start_date = formatDateString(dateString: castToString(param.start_date), Constants.DATE_FORMAT, Constants.DATE_PARAM_FORMAT)
//        param.end_date = formatDateString(dateString: castToString(param.end_date), Constants.DATE_FORMAT, Constants.DATE_PARAM_FORMAT)
        param.method = 0
    }
    
    @IBAction private func createPayment() {
        ConfirmVC.show(title: "Xác nhận", msg: "Bạn có chắc chắn thực hiện thao tác này?") {
            self.viewModel.createSchedule(param: self.param) { success, msg in
                if success {
                    AlertVC.show(viewController: self, msg: msg) {
                        self.backScreen()
                    }
                } else {
                    AlertVC.show(viewController: self, msg: msg)
                }
            }
        }
    }
}

