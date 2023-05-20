//
//  BannerViewCell.swift
//  GymCare
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

    func fillData(data: NewsModel) {
        titleLabel.text = data.title
        bannerImageView.loadImage(urlString: data.image, access: "news")
    }

}
