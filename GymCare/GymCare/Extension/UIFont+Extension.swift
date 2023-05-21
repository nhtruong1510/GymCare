//
//  UIFont+Extension.swift
//  GymCare
//
//

import Foundation
import UIKit

extension UIFont {

    static func Bold(size: CGFloat) -> UIFont {
        return UIFont.init(name: "SFProDisplay-Bold", size: size)!
    }

    static func Regular(size: CGFloat) -> UIFont {
        return UIFont.init(name: "SFProDisplay-Regular", size: size)!
    }

    static func Light(size: CGFloat) -> UIFont {
        return UIFont.init(name: "SFProDisplay-Light", size: size)!
    }
}
