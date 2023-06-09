//
//  BaseView.swift
//
//

import Foundation
import UIKit

class BaseView: UIView {

    @IBOutlet weak var inputTextView: UIView!

    enum InputFieldViewStatus {
        case active
        case inactive
    }

    var status: InputFieldViewStatus = .active {
        didSet {
            switch status {
            case .active:
                inputTextView.layer.borderColor = UIColor.main_color.cgColor
            case .inactive:
                inputTextView.layer.borderColor = UIColor.clear.cgColor
            }
        }
    }

}
