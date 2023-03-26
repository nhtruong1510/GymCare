//
//  ScheduleViewCell.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 25/02/2023.
//

import UIKit

class ScheduleViewCell: UITableViewCell {

    @IBOutlet private weak var classLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var cancelButton: UIButton!

    var onClickCancel: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func fillData(data: Time) {
        classLabel.text = data.className
        addressLabel.text = data.address
        timeLabel.text = data.time
        if let time = data.isCancelled, time == 1 {
            cancelButton.backgroundColor = .lightGray
            cancelButton.isUserInteractionEnabled = false
            cancelButton.titleLabel?.font = UIFont.Bold(size: 8)
            cancelButton.setTitle("Đã huỷ", for: .normal)
        } else {
            cancelButton.backgroundColor = .main_color
            cancelButton.isUserInteractionEnabled = true
            cancelButton.titleLabel?.font = UIFont.Bold(size: 12)
            cancelButton.setTitle("Huỷ", for: .normal)
        }
    }
    
    @IBAction private func cancelClick() {
        if let onClickCancel = onClickCancel {
            onClickCancel()
        }
    }
    
}
