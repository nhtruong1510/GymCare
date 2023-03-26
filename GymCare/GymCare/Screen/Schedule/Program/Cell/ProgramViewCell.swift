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
    @IBOutlet private weak var registerButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func fillData(data: Class) {
        titleLabel.text = data.name
        iconImageView.loadImage(urlString: data.thump_img)
        if let current = data.currentParticipate, let max = data.maxParticipate {
            registerButton.backgroundColor = current == max ? .lightGray : .color_46C0FF
            registerLabel.text = "Còn " + castToString(max - current)
        } else {
            registerLabel.isHidden = true
        }

    }
    
}
