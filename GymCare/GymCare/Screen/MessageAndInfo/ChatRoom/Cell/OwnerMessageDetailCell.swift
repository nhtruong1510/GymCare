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
        imageContantView.isHidden = data.attachments.count == 0
        if data.attachments.count > 0 {
            attachmentImageView.loadImage(urlString: data.attachments[0].sourceUrl)
        }
        timeLabel.text = data.insDatetime
    }

    @IBAction private func onClickButton(_ sender: Any) {
        viewImage?()
    }

}
