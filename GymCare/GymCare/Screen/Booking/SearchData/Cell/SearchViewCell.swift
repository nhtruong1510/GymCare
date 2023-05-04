//
//  SearchViewCell.swift
//  AppPit
//
//  Created by Truong Nguyen Huu on 11/09/2022.
//

import UIKit

class SearchViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var distanceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func fillData(data: RegionObject, seletedData: RegionObject?) {
        distanceLabel.isHidden = data.distance == nil
        if let distance = data.distance {
            distanceLabel.text = castToString(distance) + " km"
        }
        titleLabel.text = data.name
        let iconImage = data._id == seletedData?._id ? #imageLiteral(resourceName: "ic_checked_radio_button") : #imageLiteral(resourceName: "ic_uncheck_radio_button")
        iconImageView.image = iconImage
        if let avatar = data.avatar {
            avatarImageView.loadImage(urlString: avatar, access: "user")
            avatarImageView.isHidden = false
            iconImageView.image = nil
        }
    }
}
