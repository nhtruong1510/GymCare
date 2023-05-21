//
//  OtherVC.swift
//  GymCare
//
//

import UIKit
import SwiftUI

class OtherVC: BaseViewController {
    @Environment(\.presentationMode) var presentationMode

    enum TagButton: Int {
        case profile
        case fee
        case noti
        case setting
        case logout
    }

    @IBOutlet private weak var avatarImageView: AvatarView!
    @IBOutlet private weak var nameLabel: UILabel!

    private let viewModel = OtherViewModel()
    private let parentInfo = ServiceSettings.shared.userInfo

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        configUI()
    }

    private func configUI() {
        guard let userInfo = ServiceSettings.shared.userInfo else { return }
        avatarImageView.setupAvatarView(avatar: userInfo.avatar, gender: userInfo.gender)
        nameLabel.text = userInfo.name
    }


    @IBAction private func onClickButton(_ sender: UIButton) {
        switch TagButton(rawValue: sender.tag) {
        case .profile:
            nextScreen(ctrl: EditInforAcCountVC())
        case .fee:
            self.nextScreen(ctrl: ListPaymentVC())
        case .noti:
            self.nextScreen(ctrl: NotificationVC())
        case .setting:
            self.nextScreen(ctrl: SettingVC())
        case .logout:
            self.actionLogout()
        default:
            break
        }
    }

    private func actionLogout() {
        ConfirmVC.show(viewController: self, title: "Xác nhận",
                       msg: "Bạn có chắc chắn muốn đăng xuất?",
                       titleButtonLeft: "Đăng xuất",
                       titleButtonRight: "Huỷ") {
            ServiceSettings.shared.clearUserInfo()
            self.presentSwiftUIView()
        }
    }
    
    func presentSwiftUIView() {
        let swiftUIView = ContentView().preferredColorScheme(.light)
        let hostingController = UIHostingController(rootView: swiftUIView)
        hostingController.modalPresentationStyle = .fullScreen
        present(hostingController, animated: false, completion: nil)
    }
}

struct OtherVCRepresentation: UIViewControllerRepresentable {
    // 4
    typealias UIViewControllerType = OtherVC
    
    // 5
    func makeUIViewController(context: Context) -> OtherVC {
        OtherVC()
    }
    
    // 6
    func updateUIViewController(_ uiViewController: OtherVC, context: Context) {
        
    }
    
}
