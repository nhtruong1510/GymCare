//
//  UIWindow+Extension.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 13/05/2023.
//

import Foundation

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
