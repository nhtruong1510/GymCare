//
//  PaymentViewCell.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 26/03/2023.
//

import UIKit

class PaymentViewCell: UITableViewCell {

    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var moneyLabel: UILabel!

    var showDetail: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func fillData(notify: Payment) {
        dateLabel.text = formatDateString(dateString: castToString(notify.date_create),
                                          Constants.DATE_PARAM_FORMAT,
                                          Constants.DATE_FORMAT)
        contentLabel.text = notify.paymentClass?.name
        moneyLabel.text = castToString(notify.money).formatMoney() + " VNĐ"
    }

    @IBAction private func showDetailButton(_ sender: Any) {
        if let showDetail = showDetail {
            showDetail()
        }
    }
    
}
