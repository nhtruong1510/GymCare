//
//  PaymentDetailVC.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 26/03/2023.
//

import UIKit

class PaymentDetailVC: BaseViewController {

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

    var param = Payment()
    private let userInfo = ServiceSettings.shared.userInfo

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
        addressLabel.text = param.address?.address
        dayLabel.text = param.day
        timeLabel.text = param.time
        if let trainer = param.trainer {
            trainerLabel.text = trainer.name
            trainerView.isHidden = false
        }
//        let start_date = formatDateString(dateString: castToString(param.start_date), Constants.DATE_PARAM_FORMAT, Constants.DATE_FORMAT)
//        let end_date = formatDateString(dateString: castToString(param.end_date), Constants.DATE_PARAM_FORMAT, Constants.DATE_FORMAT)
        expiredLabel.text = param.date
        amountLabel.text = castToString(param.money).formatMoney() + " VNĐ"
    }
}

