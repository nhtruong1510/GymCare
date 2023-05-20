//
//  MessageViewCell.swift
//  GymCare
//
//

import UIKit

class MessageViewCell: UITableViewCell {

    @IBOutlet private weak var avatarView: AvatarView!
    @IBOutlet private weak var nameTeacherLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var titleInfoLabel: UILabel!
    @IBOutlet private weak var isReadView: UIView!
    
    var onClick: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func fillData(data: Chat) {
        let owenr = data.trainer
        avatarView.setupAvatarView(avatar: owenr?.avatar, gender: owenr?.gender)
        nameTeacherLabel.text = owenr?.name
        dateLabel.text = formatDateString(dateString: castToString(data.insDatetime),
                                          Constants.DATE_TIME_FORMAT,
                                          Constants.DATE_FORMAT)
        if dateLabel.text == Date().toString() {
            dateLabel.text = "Hôm nay"
        }
        let beginMsg = "Gửi lời chào đến " + castToString(owenr?.name)
        let isStartMsg = castToInt(data.lastMessage?.count) == 0
        titleInfoLabel.text = isStartMsg ? beginMsg : data.lastMessage
        titleInfoLabel.font = data.isRead() ? .Light(size: 12) : .Bold(size: 12)
        isReadView.backgroundColor = data.isRead() ? UIColor.gray : UIColor.main_color
        isReadView.isHidden = data.isRead()
    }
    
    @IBAction private func onClickMessage() {
        onClick?()
    }
    
}
