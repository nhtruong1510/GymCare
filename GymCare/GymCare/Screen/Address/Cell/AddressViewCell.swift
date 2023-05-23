//
//  AddressViewCell.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 09/03/2023.
//

import UIKit

class AddressViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var registerLabel: UILabel!
    @IBOutlet private weak var distanceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func fillData(data: Address) {
        titleLabel.text = data.address
        iconImageView.loadImage(urlString: data.image, access: "address")
//        if let current = data.addressClass?.currentParticipate, let max = data.addressClass?.maxParticipate {
////            registerButton.backgroundColor = current == max ? .lightGray : .color_46C0FF
//            registerLabel.text = "Còn " + castToString(max - current) + " suất"
////            registerLabel.isHidden = false
//        } else {
////            registerLabel.isHidden = true
//        }
        registerLabel.text = castToString(data.addressClass?.money).formatMoney() + " đ/tháng"
        if let distance = data.distance {
            distanceLabel.text = castToString(distance) + " Km"
        } else {
            distanceLabel.text = ""
        }
    }
    

}
