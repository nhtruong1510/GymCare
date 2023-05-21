//
//  HomeVC.swift
//  GymCare
//
//

import UIKit
import SwiftUI

class HomeVC: BaseViewController {

    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var avatarStudentView: AvatarView!
    @IBOutlet private weak var nameStudentLabel: UILabel!
    @IBOutlet private weak var totalNotiUnreadLabel: UILabel!
    @IBOutlet private weak var totalNotiUnreadView: UIView!

    private let viewModel = HomeViewModel()
    private lazy var bannerView = BannerView()
    private lazy var managementView = ManagementView()
    private lazy var notiView = NotiView()
    private let userInfo = ServiceSettings.shared.userInfo

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        configUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavi()
    }

    private func getData() {
        viewModel.callApiGetClasses { [weak self] (response, msg) in
            guard let `self` = self else { return }
            if let response = response {
                self.fillData(classModel: response)
            } else {
                AlertVC.show(viewController: self, msg: msg)
            }
        }
        viewModel.callApiGetNews { [weak self] (response, msg) in
            guard let `self` = self else { return }
            if let response = response {
                self.fillDataBanner(data: response)
            } else {
                AlertVC.show(viewController: self, msg: msg)
            }
        }
    }

    private func configUI() {
        stackView.addArrangedSubview(bannerView)
        bannerView.isHidden = true
        stackView.addArrangedSubview(notiView)
        notiView.isHidden = true
        stackView.addArrangedSubview(managementView)
        managementView.isHidden = true
        fillData(classModel: ClassModel())
        avatarStudentView.setupAvatarView(avatar: userInfo?.avatar, gender: userInfo?.gender)
        nameStudentLabel.text = userInfo?.name
        
    }

    private func setupNavi() {
        DispatchQueue.main.async {
            self.notiView.reloadData(notis: ServiceSettings.shared.listLastestSchedule)
        }
    }

    private func fillDataBanner(data: [NewsModel]) {
        if data.count > 0 {
            bannerView.isHidden = false
            bannerView.reloadData(datas: data)
        }
    }
    
    private func fillData(classModel: ClassModel) {
        managementView.isHidden = false
        managementView.reloadData(items: classModel.classes ?? [])
        managementView.onClick = { [weak self] classModel in
            guard let `self` = self else { return }
            let vc = ContentProgramVC()
            vc.classModel = classModel
            self.nextScreen(ctrl: vc)
        }
        managementView.onClickMore = { [weak self] in
            guard let `self` = self else { return }
            let vc = ProgramVC()
            vc.listSearchData = classModel.classes ?? []
            self.nextScreen(ctrl: vc)
        }
//        if ServiceSettings.shared.listLastestSchedule.count > 0 {
//            notiView.isHidden = false
//            DispatchQueue.main.async {
//                self.notiView.reloadData(notis: ServiceSettings.shared.listLastestSchedule)
//            }
//        }
//        notiView.onClickNoti = { [weak self] notiId in
//            guard let `self` = self else  { return }
//            let vc = BookingVC()
//            self.nextScreen(ctrl: vc)
//        }
//        notiView.onClickMore = {
//            let response: [String: Int] = ["type": Constants.notification]
//            NotificationCenter.default.post(name: .GO_TAP_MESSAGE, object: nil, userInfo: response)
//        }

    }
}

// 3
struct HomeVCRepresentation: UIViewControllerRepresentable {
    // 4
    typealias UIViewControllerType = HomeVC
    
    // 5
    func makeUIViewController(context: Context) -> HomeVC {
        HomeVC()
    }
    
    // 6
    func updateUIViewController(_ uiViewController: HomeVC, context: Context) {
        
    }
}
