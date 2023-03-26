//
//  MessageViewCell.swift
//  SchoolUpTeacher
//
//  Created by Nguyen Ha on 10/01/2023.
//

import UIKit

class MessageViewCell: UITableViewCell {

    @IBOutlet private weak var avatarView: AvatarView!
    @IBOutlet private weak var nameTeacherLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var titleInfoLabel: UILabel!
    @IBOutlet private weak var isReadView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func fillData(data: TopicDetailModel) {
        let owenr = data.owner
        avatarView.setupAvatarView(avatar: owenr?.avatar, gender: owenr?.gender)
        nameTeacherLabel.text = data.name
        dateLabel.text = data.insDatetime
        titleInfoLabel.text = data.content
//        isReadView.backgroundColor = data.isRead() ? UIColor.color_CBCBCB : UIColor.color_00BAFF
    }
    
}
