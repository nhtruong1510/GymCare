//
//  ConfirmVC.swift
//  SchoolUpTeacher
//
//  Created by Truong Nguyen Huu on 29/12/2022.
//

import UIKit

class ConfirmVC: UIViewController {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var doneButton: UIButton!
    @IBOutlet private weak var cancelButton: UIButton!

    var titleStr: String?
    var msg: String?
    var titleButtonLeft: String?
    var titleButtonRight: String?

    var onClickConfirm: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    private func configUI() {
        titleLabel.text = titleStr
        contentLabel.text = msg
        doneButton.setTitle(titleButtonLeft, for: .normal)
        cancelButton.setTitle(titleButtonRight, for: .normal)
    }

    init(title: String?, msg: String?, titleButtonLeft: String?, titleButtonRight: String?) {
        self.titleStr = title
        self.msg = msg
        self.titleButtonLeft = titleButtonLeft
        self.titleButtonRight = titleButtonRight
        super.init(nibName: "ConfirmVC", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    static func show(viewController: UIViewController, title: String?, msg: String?, titleButtonLeft: String? = "Xác nhận", titleButtonRight: String? = "Huỷ", completion:(() -> Void)? = nil) {
        let confirmVC = ConfirmVC(title: title, msg: msg, titleButtonLeft: titleButtonLeft, titleButtonRight: titleButtonRight)
        confirmVC.onClickConfirm = {
            if let completion = completion {
                completion()
            }
        }
        viewController.present(confirmVC, animated: true)
    }

    @IBAction func cancelClick(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func confirmClick(_ sender: Any) {
        self.dismiss(animated: true) { [weak self] in
            guard let `self` = self, let onClick = self.onClickConfirm else { return }
            onClick()
        }
    }

}
