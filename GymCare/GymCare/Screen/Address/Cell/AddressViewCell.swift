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
        iconImageView.loadImage(urlString: data.image)
        if let current = data.addressClass?.currentParticipate, let max = data.addressClass?.maxParticipate {
//            registerButton.backgroundColor = current == max ? .lightGray : .color_46C0FF
            registerLabel.text = "Còn " + castToString(max - current) + " suất"
            registerLabel.isHidden = false
        } else {
            registerLabel.isHidden = true
        }
        if let lattitude = data.lattitude, let longitude = data.longitude {
            let distance = getDistance(lat1: Constants.LATITUDE, lon1: Constants.LONGTITUDE, lat2: lattitude, lon2: longitude, unit: "K")
            distanceLabel.text = distance
        } else {
            distanceLabel.text = ""
        }
    }
    
    func getDistance(lat1: Double, lon1: Double, lat2: Double, lon2: Double, unit: String) -> String {
        let radlat1 = Double.pi * lat1 / 180
        let radlat2 = Double.pi * lat2 / 180
        let theta = lon1 - lon2
        let radtheta = Double.pi * theta / 180
        var dist = sin(radlat1) * sin(radlat2) + cos(radlat1) * cos(radlat2) * cos(radtheta)
        dist = acos(dist)
        dist = dist * 180 / Double.pi
        dist = dist * 60 * 1.1515
        if unit == "K" { dist = dist * 1.609344 }
        if unit == "M" { dist = dist * 0.8684 }
        return "\(dist.rounded(toPlaces: 1)) km"
    }
}
