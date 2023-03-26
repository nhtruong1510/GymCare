//
//  BannerViewCell.swift
//  SchoolUpTeacher
//
//  Created by Nguyễn Hà on 01/01/2023.
//

import UIKit

class BannerViewCell: UICollectionViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var bannerImageView: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func fillData(data: BannerModel) {
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        bannerImageView.loadImage(urlString: data.sourceUrl)
    }

}
