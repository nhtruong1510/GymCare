//
//  BabyManagementView.swift
//  GymCare
//
//  Created by Nguyễn Hà on 01/01/2023.
//

import UIKit

class ManagementView: UIView {

    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet weak var heightCollectionViewConstraint: NSLayoutConstraint!

    var items: [Class] = []
    var onClick: ((Class) -> Void)?
    var onClickMore: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.registerCells(from: .managementViewCell)
    }

    private func setupView() {
        Bundle.main.loadNibNamed("ManagementView", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        let collectionViewWidth = ((self.collectionView.bounds.width - 32) / 2) + 15
        self.heightCollectionViewConstraint.constant = collectionViewWidth * (3/2) + collectionViewWidth

    }

    func reloadData(items: [Class]) {
        self.items = items
        collectionView.reloadData { [weak self] in
            guard let `self` = self else { return }
            let height = self.collectionView.collectionViewLayout.collectionViewContentSize.height
            self.heightCollectionViewConstraint.constant = height
            self.collectionView.setNeedsLayout()
            self.layoutIfNeeded()
        }
//        collectionView.reloadData()
    }

    @IBAction private func moreClick() {
        if let onClick = onClickMore {
            onClick()
        }
    }
}

extension ManagementView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ManagementViewCell.dequeueReuse(collectionView: collectionView, indexPath: indexPath)
        cell.fillData(item: items[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let onClick = onClick {
            onClick(items[indexPath.row])//castToString(items[indexPath.row].menuPermissions))
        }
    }

}

extension ManagementView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.collectionView.bounds.width - 32) / 2
        let height = width + 25
        return CGSize(width: width, height: height)
    }

}
