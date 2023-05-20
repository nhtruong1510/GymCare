//
//  BannerCollectionViewFlowLayout.swift
//  GymCare
//
//

import UIKit

class BannerCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override func prepare() {
        super.prepare()
        scrollDirection = .horizontal
        minimumLineSpacing = 16
        minimumInteritemSpacing = 16
        itemSize = CGSize(width: 32, height: 32)
    }

}
