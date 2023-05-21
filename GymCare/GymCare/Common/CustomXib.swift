//
//  CustomXib.swift
//  GymCare
//
//

import Foundation
import UIKit

enum CustomXib: String {
    
    // MARK: -- Cell
    case ownerMessageDetailCell = "OwnerMessageDetailCell"
    case teacherMessageDetailCell = "TeacherMessageDetailCell"
    case messageViewCell = "MessageViewCell"
    case searchViewCell = "SearchViewCell"
    case bannerViewCell = "BannerViewCell"
    case managementViewCell = "ManagementViewCell"
    case notiViewCell = "NotiViewCell"
    case scheduleViewCell = "ScheduleViewCell"
    case dateCell = "DateCell"
    case programViewCell = "ProgramViewCell"
    case addressViewCell = "AddressViewCell"
    case notificationViewCell = "NotificationViewCell"
    case paymentViewCell = "PaymentViewCell"
    
    //MARK: -- HeaderFooter
    case dateHeader = "DateHeader"

    func loadNib() -> UINib {
        return UINib(nibName: self.rawValue, bundle: nil)
    }
    
    func loadView(_ owner: Any? = nil) -> UIView {
        let nib = loadNib()
        let views = nib.instantiate(withOwner: owner, options: nil)
        if let view = views.first as? UIView {
            return view
        }
        return UIView()
    }
}

extension OwnerMessageDetailCell {
    static func dequeueReuse(tableView: UITableView) -> OwnerMessageDetailCell {
        if let cell = tableView.dequeReuseCell(xib: .ownerMessageDetailCell) as? OwnerMessageDetailCell {
            return cell
        }
        fatalError("DEVELOP ERROR: The registered cell type for identifier \"\(CustomXib.ownerMessageDetailCell.rawValue)\"!")
    }
}

extension TeacherMessageDetailCell {
    static func dequeueReuse(tableView: UITableView) -> TeacherMessageDetailCell {
        if let cell = tableView.dequeReuseCell(xib: .teacherMessageDetailCell) as? TeacherMessageDetailCell {
            return cell
        }
        fatalError("DEVELOP ERROR: The registered cell type for identifier \"\(CustomXib.teacherMessageDetailCell.rawValue)\"!")
    }
}

extension MessageViewCell {
    static func dequeueReuse(tableView: UITableView) -> MessageViewCell {
        if let cell = tableView.dequeReuseCell(xib: .messageViewCell) as? MessageViewCell {
            return cell
        }
        fatalError("DEVELOP ERROR: The registered cell type for identifier \"\(CustomXib.messageViewCell.rawValue)\"!")
    }
}

extension SearchViewCell {
    static func dequeueReuse(tableView: UITableView) -> SearchViewCell {
        if let cell = tableView.dequeReuseCell(xib: .searchViewCell) as? SearchViewCell {
            return cell
        }
        fatalError("DEVELOP ERROR: The registered cell type for identifier \"\(CustomXib.searchViewCell.rawValue)\"!")
    }
}

extension NotiViewCell {
    static func dequeueReuse(tableView: UITableView) -> NotiViewCell {
        if let cell = tableView.dequeReuseCell(xib: .notiViewCell) as? NotiViewCell {
            return cell
        }
        fatalError("DEVELOP ERROR: The registered cell type for identifier \"\(CustomXib.notiViewCell.rawValue)\"!")
    }
}

extension ScheduleViewCell {
    static func dequeueReuse(tableView: UITableView) -> ScheduleViewCell {
        if let cell = tableView.dequeReuseCell(xib: .scheduleViewCell) as? ScheduleViewCell {
            return cell
        }
        fatalError("DEVELOP ERROR: The registered cell type for identifier \"\(CustomXib.scheduleViewCell.rawValue)\"!")
    }
}

extension ProgramViewCell {
    static func dequeueReuse(tableView: UITableView) -> ProgramViewCell {
        if let cell = tableView.dequeReuseCell(xib: .programViewCell) as? ProgramViewCell {
            return cell
        }
        fatalError("DEVELOP ERROR: The registered cell type for identifier \"\(CustomXib.programViewCell.rawValue)\"!")
    }
}

extension AddressViewCell {
    static func dequeueReuse(tableView: UITableView) -> AddressViewCell {
        if let cell = tableView.dequeReuseCell(xib: .addressViewCell) as? AddressViewCell {
            return cell
        }
        fatalError("DEVELOP ERROR: The registered cell type for identifier \"\(CustomXib.addressViewCell.rawValue)\"!")
    }
}

extension NotificationViewCell {
    static func dequeueReuse(tableView: UITableView) -> NotificationViewCell {
        if let cell = tableView.dequeReuseCell(xib: .notificationViewCell) as? NotificationViewCell {
            return cell
        }
        fatalError("DEVELOP ERROR: The registered cell type for identifier \"\(CustomXib.notificationViewCell.rawValue)\"!")
    }
}

extension PaymentViewCell {
    static func dequeueReuse(tableView: UITableView) -> PaymentViewCell {
        if let cell = tableView.dequeReuseCell(xib: .paymentViewCell) as? PaymentViewCell {
            return cell
        }
        fatalError("DEVELOP ERROR: The registered cell type for identifier \"\(CustomXib.paymentViewCell.rawValue)\"!")
    }
}

// MARk: Exten CollectionCell
extension BannerViewCell {
    static func dequeueReuse(collectionView: UICollectionView, indexPath: IndexPath) -> BannerViewCell {
        if let cell = collectionView.dequeReuseCell(xib: .bannerViewCell, indexPath: indexPath) as? BannerViewCell {
            return cell
        }
        fatalError("DEVELOP ERROR: The registered cell type for identifier \"\(CustomXib.bannerViewCell.rawValue)\"!")
    }
}

extension ManagementViewCell {
    static func dequeueReuse(collectionView: UICollectionView, indexPath: IndexPath) -> ManagementViewCell {
        if let cell = collectionView.dequeReuseCell(xib: .managementViewCell, indexPath: indexPath) as? ManagementViewCell {
            return cell
        }
        fatalError("DEVELOP ERROR: The registered cell type for identifier \"\(CustomXib.managementViewCell.rawValue)\"!")
    }
}

extension DateCell {
    static func dequeueReuse(collectionView: UICollectionView, indexPath: IndexPath) -> DateCell {
        if let cell = collectionView.dequeReuseCell(xib: .dateCell, indexPath: indexPath) as? DateCell {
            return cell
        }
        fatalError("DEVELOP ERROR: The registered cell type for identifier \"\(CustomXib.dateCell.rawValue)\"!")
    }
}

extension DateHeader {
    static func dequeueReuse(collectionView: UICollectionView, indexPath: IndexPath) -> DateHeader {
        if let cell = collectionView.dequeReuseView(xib: .dateHeader, indexPath: indexPath, ofKind: "") as? DateHeader {
            return cell
        }
        fatalError("DEVELOP ERROR: The registered cell type for identifier \"\(CustomXib.dateHeader.rawValue)\"!")
    }
}
