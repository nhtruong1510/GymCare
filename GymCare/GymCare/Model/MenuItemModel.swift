//
//  MenuItemModel.swift
//  GymCare
//
//

import Foundation
import UIKit

class MenuItemModel {

    var title: String?
    var icon: UIImage?
    var permission: String?
    var menuPermissions: String?
    var badge: Int?

    init() {
        
    }

    init(title: String? = nil, icon: UIImage? = nil,
         permission: String? = nil, menuPermissions: String? = nil,
         badge: Int? = nil ) {
        self.title = title
        self.icon = icon
        self.permission = permission
        self.menuPermissions = menuPermissions
        self.badge = badge
    }

}
