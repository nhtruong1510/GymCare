//
//  ProgramViewCell.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 27/02/2023.
//

import UIKit

class ProgramViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var registerLabel: UILabel!
    @IBOutlet private weak var registerView: UIView!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var widthConstrant: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func fillData(data: Class) {
        titleLabel.text = data.name
        iconImageView.loadImage(urlString: data.image, access: "class")
        if let current = data.currentParticipate, let max = data.maxParticipate {
            registerView.backgroundColor = current == max ? .lightGray : .color_46C0FF
            registerLabel.text = "Còn " + castToString(max - current)
        } else {
            registerLabel.isHidden = true
        }
        registerView.isHidden = false
    }
    
    func fillDataEdit(data: ScheduleModel) {
        titleLabel.text = castToInt(data.schedules?.count) > 0 ? data.schedules?[0].scheduleClass?.name : nil
        widthConstrant.constant = 0
        registerLabel.isHidden = true
        registerView.isHidden = true
    }
    
    func fillDataEdit1(data: Schedule) {
        titleLabel.text = data.address?.address
        let startDate = formatDateString(dateString: castToString(data.start_date),
                                         Constants.DATE_PARAM_FORMAT,
                                         Constants.DATE_FORMAT)
        let endDate = formatDateString(dateString: castToString(data.end_date),
                                         Constants.DATE_PARAM_FORMAT,
                                         Constants.DATE_FORMAT)
        let date = castToString(startDate) + " - " + castToString(endDate)
        timeLabel.text = date
        widthConstrant.constant = 0
        registerLabel.isHidden = true
        registerView.isHidden = false
    }
    
}
