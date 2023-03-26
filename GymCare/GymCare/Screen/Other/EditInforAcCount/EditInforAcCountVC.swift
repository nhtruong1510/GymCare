//
//  EditInforAcCountVC.swift
//  CameraAI
//
//  Created by MrMajiruana on 10/31/21.
//

import UIKit
import AVFoundation

class EditInforAcCountVC: BaseViewController {

    @IBOutlet private weak var imageAvatar: AvatarView!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var phoneTextField: UITextField!
    @IBOutlet private weak var addressTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var nameTitleLabel: UILabel!
    @IBOutlet private weak var emailTitleLabel: UILabel!
    @IBOutlet private weak var phoneNumberTitleLabel: UILabel!
    @IBOutlet private weak var addressTitleLabel: UILabel!

    private var viewModel = SettingViewModel()
    private var isChangedAvatar: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        getDetailTeacher()
        touchOut()
    }

    private func getDetailTeacher(completion: (() -> Void)? = nil) {
//        viewModel.getTeacherInfo { [weak self] data, msg in
//            guard let `self` = self else { return }
//            if let data = data {
//                self.configUI(data: data)
//                if let completion = completion {
//                    completion()
//                }
//            } else {
//                AlertVC.show(msg: msg)
//            }
//        }
    }

    private func updateTeacher() {
//        ConfirmVC.show(title: "confirm".localized, msg: "are_you_sure".localized,
//                       titleButtonLeft: "ok".localized, titleButtonRight: "cancel".localized ) { [weak self] in
//            guard let `self` = self else { return }
//            let param = TeacherModel()
//            param.id = ServiceSettings.shared.parentInfo?.id
//            param.name = self.nameTextField.text
//            param.email = self.emailTextField.text
//            param.phoneNumber = self.phoneTextField.text
//            param.address = self.addressTextField.text
//            if self.isChangedAvatar {
//                param.avatarFile = self.imageAvatar.avatarView.image
//            }
//            self.viewModel.updateTeacherInfo(value: param) { status, msg in
//                if status {
//                    self.getDetailTeacher() {
//                        AlertVC.show(msg: msg) { [weak self] in
//                            guard let `self` = self else { return }
//                            self.backScreen()
//                        }
//                    }
//                } else {
//                    AlertVC.show(msg: msg)
//                }
//            }
//        }
    }

//    private func configUI(data: TeacherModel) {
//        imageAvatar.setupAvatarView(avatar: data.avatar, gender: data.gender)
//        nameLabel.text = castToString(data.name)
//        nameTextField.text = castToString(data.name)
//        phoneTextField.text = castToString(data.phoneNumber)
//        addressTextField.text = castToString(data.address)
//        emailTextField.text = castToString(data.email)
//        self.viewModel.saveUserInfor(teacherDetail: data)
//    }

    @IBAction func backClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func openCameraClick(_ sender: Any) {
        guard let topView = UIApplication.shared.windows.first?.rootViewController else {return}
        ImagePickerManager().pickImage(topView, chooseVideo: false, singleSelectedMode: true) { [weak self] assets in
            guard let `self` = self, assets.count > 0 else { return }
            let image = assets[0].fullResolutionImage ?? UIImage()
            self.imageAvatar.avatarView.image = image
            self.isChangedAvatar = true
        }
    }

    @IBAction func updateInforClick(_ sender: Any) {
//        ConfirmVC.show(title: "confirm".localized, msg: "are_you_sure".localized,
//                       titleButtonLeft: "ok".localized, titleButtonRight: "cancel".localized ) { [weak self] in
//            guard let `self` = self else { return }
//            self.updateTeacher()
//        }
    }
}

extension EditInforAcCountVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        setHightlightLabel(textField, color: .color_46C0FF)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
//        setHightlightLabel(textField, color: .color_707070)
    }

    func setHightlightLabel(_ textField: UITextField, color: UIColor) {
        switch textField {
        case nameTextField:
            nameTitleLabel.textColor = color
        case phoneTextField:
            phoneNumberTitleLabel.textColor = color
        case addressTextField:
            addressTitleLabel.textColor = color
        case emailTextField:
            emailTitleLabel.textColor = color
        default: break
        }
    }
}
