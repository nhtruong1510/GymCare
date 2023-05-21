//
//  CustomProgressHUD.swift
//
//

import Foundation
import SVProgressHUD

public enum CustomProgressHUD {
    static func showProgress(maskType: SVProgressHUDMaskType? = nil, inView: UIView? = nil) {
        if let maskType = maskType {
            SVProgressHUD.setDefaultMaskType(maskType)
        }

        if let inview = inView {
            SVProgressHUD.setContainerView(inview)
        }

        SVProgressHUD.setForegroundColor(UIColor.main_color)
        SVProgressHUD.show()
    }

    static func dismissProgress() {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }

    static func showProgress() {
        DispatchQueue.main.async {
            showProgress(maskType: .gradient, inView: UIWindow.key)
        }
    }

    static func showProgress(percent: Float) {
        SVProgressHUD.showProgress(percent)
    }
}
