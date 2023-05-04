//
//  OwnerMessageDetailCell.swift
//  SchoolUpTeacher
//
//  Created by Nguyen Ha on 12/01/2023.
//

import UIKit

class OwnerMessageDetailCell: UITableViewCell {

    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var imageContantView: UIView!
    @IBOutlet private weak var attachmentImageView: UIImageView!
    @IBOutlet private weak var timeLabel: UILabel!

    var viewImage: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        attachmentImageView.layer.masksToBounds = true
    }

    func fillData(data: MessageModel) {
        contentLabel.text = data.content
        imageContantView.isHidden = castToInt(data.image?.count) == 0
        attachmentImageView.loadImage(urlString: data.image, access: "chat")
        let year = formatDateString(dateString: castToString(data.insDatetime),
                                    Constants.DATE_TIME_FORMAT,
                                    Constants.YEAR_STRING)
        let date = formatDateString(dateString: castToString(data.insDatetime),
                                    Constants.DATE_TIME_FORMAT,
                                    Constants.DATE_FORMAT)
        if year == Date().toString(Constants.YEAR_STRING) {
            timeLabel.text = formatDateString(dateString: castToString(data.insDatetime),
                                              Constants.DATE_TIME_FORMAT,
                                              Constants.DATE_TIME_FORMAT_4)
            if date == Date().toString() {
                timeLabel.text = formatDateString(dateString: castToString(data.insDatetime),
                                                  Constants.DATE_TIME_FORMAT,
                                                  Constants.HOUR_STRING)
            }
        } else {
            timeLabel.text = formatDateString(dateString: castToString(data.insDatetime),
                                              Constants.DATE_TIME_FORMAT,
                                              Constants.DATE_TIME_FORMAT_3)
        }
    }

    @IBAction private func onClickButton(_ sender: Any) {
        viewImage?()
    }

}
