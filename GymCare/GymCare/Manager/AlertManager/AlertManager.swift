//
//  AlertManager.swift
//  SchoolUpTeacher
//
//  Created by Paraline App on 06/01/2023.
//

import UIKit

class AlertManager {
    static func actionSheet(title: String? = nil, buttons: [String], cancelStr: String, complete: @escaping(String, TypeAction) -> Void) {
        var alertStyle = UIAlertController.Style.actionSheet
        if (UIDevice.current.userInterfaceIdiom == .pad) {
            alertStyle = UIAlertController.Style.alert
        }
        
        let actionSHEET = UIAlertController(title: "", message: title, preferredStyle: alertStyle)
        
        let cancelAction = UIAlertAction(title: cancelStr, style: .cancel) {
            (result : UIAlertAction) -> Void in
            complete(result.title!, .cancel)
        }
        actionSHEET.addAction(cancelAction)
        
        for item in buttons {
            let action = UIAlertAction(title: item, style: .default, handler: { (result) in
                complete(result.title!, .ok)
            })
            actionSHEET.addAction(action)
        }
        
//        AppDelegate.shared.topMost?.present(actionSHEET, animated: true, completion: nil)
    }
}
