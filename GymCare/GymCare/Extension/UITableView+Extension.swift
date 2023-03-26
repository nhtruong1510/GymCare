//
//  UITableView+Extension.swift
//  AppPit
//
//  Created by Nguyễn Hà on 01/08/2022.
//

import Foundation
import UIKit

extension UITableView {

    func registerCell<T: UITableViewCell>(type: T.Type) {
        self.register(nibFromClass(type), forCellReuseIdentifier: nameOfClass(type))
    }

    func dequeueReusableCell<T: UITableViewCell>(type: T.Type) -> T? {
        return self.dequeueReusableCell(withIdentifier: nameOfClass(type)) as? T
    }

    func dequeueAndRegisterCell<T: UITableViewCell>(type: T.Type) -> T? {
        self.registerCell(type: type)
        return self.dequeueReusableCell(type: type)
    }

    func registerCells(from xibs: CustomXib...) {
        for xib in xibs {
            register(xib.loadNib(), forCellReuseIdentifier: xib.rawValue)
        }
    }
    
    func registerHeaderFooterView(from xibs: CustomXib...) {
        for xib in xibs {
            register(xib.loadNib(), forHeaderFooterViewReuseIdentifier: xib.rawValue)
        }
    }

    func dequeReuseCell(xib: CustomXib) -> UITableViewCell {
        if let cell = dequeueReusableCell(withIdentifier: xib.rawValue) {
            return cell
        }
        fatalError("DEVELOP ERROR: \"\(xib.rawValue)\" is not registed as reusaable table view cell!")
    }
    
    func dequeReuseHeaderFooterView(xib: CustomXib) -> UITableViewHeaderFooterView {
        if let cell = dequeueReusableHeaderFooterView(withIdentifier: xib.rawValue) {
            return cell
        }
        fatalError("DEVELOP ERROR: \"\(xib.rawValue)\" is not registed as reusaable table view cell!")
    }

    func reloadTable() {
        let contentOffset = self.contentOffset
        self.reloadData()
        self.layoutIfNeeded()
        self.setContentOffset(contentOffset, animated: false)
    }

    func reloadData(completion:@escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: reloadData) { _ in
            completion()
        }
    }
}

extension UICollectionView {
    func registerCells(from xibs: CustomXib...) {
        for xib in xibs {
            register(xib.loadNib(), forCellWithReuseIdentifier: xib.rawValue)
        }
    }

    func registerCellsFooterHeader(from xibs: CustomXib..., ofKind: String) {
        for xib in xibs {
            self.register(xib.loadNib(), forSupplementaryViewOfKind: ofKind, withReuseIdentifier: xib.rawValue)
        }
    }

    func dequeReuseCell(xib: CustomXib, indexPath: IndexPath) -> UICollectionViewCell {
        return dequeueReusableCell(withReuseIdentifier: xib.rawValue, for: indexPath)
    }
    
    func reloadData(completion:@escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: reloadData) { _ in
            completion()
        }
    }

    func dequeReuseView(xib: CustomXib, indexPath: IndexPath, ofKind: String) -> UICollectionReusableView {
        return dequeueReusableSupplementaryView(ofKind: ofKind, withReuseIdentifier: xib.rawValue, for: indexPath)
    }
}

func nibFromClass<T: NSObject>(_ className: T.Type) -> UINib? {
    let name = String(describing: T.self)
    if Bundle.main.path(forResource: name, ofType: "nib") != nil || Bundle.main.path(forResource: name, ofType: "xib") != nil {
        return UINib(nibName: String(describing: T.self), bundle: nil)
    }
    return nil
}

func nameOfClass<T: NSObject>(_ type: T.Type) -> String {
    return String(describing: T.self)
}

final class ContentSizedTableView: UITableView {
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
