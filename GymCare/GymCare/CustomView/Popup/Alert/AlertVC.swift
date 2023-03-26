//
//  AlertVC.swift
//  SchoolUpTeacher
//
//  Created by Truong Nguyen Huu on 29/12/2022.
//

import UIKit

class AlertVC: UIViewController {

    @IBOutlet private weak var msgLabel: UILabel!
    @IBOutlet private weak var doneButton: UIButton!
    
    private var msg: String?
    private var buttonTitle: String?

    var onDismiss: (() -> Void)? = nil
    
    init(msg: String?, buttonTitle: String?) {
        self.msg = msg
        self.buttonTitle = buttonTitle
        super.init(nibName: "AlertVC", bundle: nil)
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }

    private func configUI() {
        self.msgLabel.text = msg
        self.doneButton.setTitle(buttonTitle, for: .normal)
    }

    @IBAction func closeClick(_ sender: Any) {
        self.dismiss(animated: true) { [weak self] in
            guard let `self` = self, let onDismiss = self.onDismiss else { return }
            onDismiss()
        }
    }

    static func show(viewController: UIViewController, msg: String?, buttonTitle: String? = "OK", completion:(() -> Void)? = nil) {
        let alertVC = AlertVC(msg: msg, buttonTitle: buttonTitle)
        alertVC.onDismiss = {
            if let completion = completion {
                completion()
            }
        }
        viewController.present(alertVC, animated: true)
    }
}
