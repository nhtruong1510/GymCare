//
//  TeacherMessageDetailCell.swift
//  SchoolUpTeacher
//
//  Created by Nguyen Ha on 12/01/2023.
//

import UIKit

class TeacherMessageDetailCell: UITableViewCell {

    @IBOutlet private weak var avatarView: AvatarView!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var imageContantView: UIView!
    @IBOutlet private weak var attachmentImageView: UIImageView!
    @IBOutlet private weak var timeLabel: UILabel!

    var viewImage: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
        attachmentImageView.layer.masksToBounds = true
        attachmentImageView.layer.cornerRadius = 20
    }

    func fillData(data: MessageModel) {
        let teacher = data.owner
        avatarView.setupAvatarView(avatar: teacher?.avatar, gender: teacher?.gender)
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
