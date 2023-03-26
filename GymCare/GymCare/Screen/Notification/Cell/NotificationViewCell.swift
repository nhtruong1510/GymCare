//
//  NotificationViewCell.swift
//  GymCareForTrainer
//
//  Created by Truong Nguyen Huu on 16/03/2023.
//

import UIKit

class NotificationViewCell: UITableViewCell {

    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var alertImageView: UIImageView!

    var showDetail: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func fillData(notify: NotifiObject) {
        dateLabel.text = formatDateString(dateString: castToString(notify.date_create),
                                          Constants.DATE_PARAM_FORMAT,
                                          Constants.DATE_FORMAT)
        contentLabel.text = notify.content
        let isRead = castToInt(notify.is_read) == 1
        alertImageView.image = isRead ? #imageLiteral(resourceName: "ic_read") : #imageLiteral(resourceName: "ic_unread")
    }

    @IBAction private func showDetailButton(_ sender: Any) {
        if let showDetail = showDetail {
            showDetail()
        }
    }

}

