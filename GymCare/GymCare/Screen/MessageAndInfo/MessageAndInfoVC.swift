//
//  MessageAndInfoVC.swift
//  SchoolUpTeacher
//
//  Created by Nguyen Ha on 09/01/2023.
//

import UIKit
import SwiftUI

class MessageAndInfoVC: BaseViewController {

    @IBOutlet private weak var containerView: UIView!

    private lazy var messageVC: MessageVC = {
        var viewController = MessageVC()
        self.addChild(viewController)
        return viewController
    }()

    var haveTopicPermission: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configNavigator()
        add(asChildViewController: messageVC)
    }
    
    private func configUI() {
        cutomNavi.onClickBack = { [weak self] in
            guard let `self` = self else { return }
            self.backScreen()
        }
    }

    private func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)
        containerView.addSubview(viewController.view)
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }

}

// 3
struct MessageAndInfoVCRepresentation: UIViewControllerRepresentable {
    // 4
    typealias UIViewControllerType = MessageAndInfoVC
    
    // 5
    func makeUIViewController(context: Context) -> MessageAndInfoVC {
        MessageAndInfoVC()
    }
    
    // 6
    func updateUIViewController(_ uiViewController: MessageAndInfoVC, context: Context) {
        
    }
}
