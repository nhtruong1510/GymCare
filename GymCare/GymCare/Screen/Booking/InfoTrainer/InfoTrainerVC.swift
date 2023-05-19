//
//  InfoTrainerVC.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 24/02/2023.
//

import UIKit

class InfoTrainerVC: BaseViewController {
    @IBOutlet private var imageAvatar: AvatarView!
    @IBOutlet private var nameTextField: UITextField!
    @IBOutlet private var addressTextField: UITextField!
    @IBOutlet private var certificateTextField: UITextField!
    @IBOutlet private var experienceTextField: UITextField!
    @IBOutlet private var specializeTextField: UITextField!

    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var nameTitleLabel: UILabel!
    @IBOutlet private var addressTitleLabel: UILabel!

    private var viewModel = SettingViewModel()
    var trainer: Trainer = Trainer()

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI(data: trainer)
//        getDetailParent()
//        touchOut()
    }

//    private func getDetailParent(completion: (() -> Void)? = nil) {
//        viewModel.callApiGetParentDetail(showLoading: true) { [weak self] data, msg in
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
//    }

    private func configUI(data: Trainer) {
        imageAvatar.setupAvatarView(avatar: data.avatar, gender: data.gender)
        nameLabel.text = castToString(data.name)
        nameTextField.text = castToString(data.name)
        experienceTextField.text = castToString(data.experience)
        certificateTextField.text = castToString(data.certificate)
        specializeTextField.text = castToString(data.specialize)
        addressTextField.text = castToString(data.address)
    }

    @IBAction func backClick(_: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension InfoTrainerVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        setHightlightLabel(textField, color: .color_46C0FF)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        setHightlightLabel(textField, color: .black)
    }

    func setHightlightLabel(_ textField: UITextField, color: UIColor) {
        switch textField {
        case nameTextField:
            nameTitleLabel.textColor = color
        case addressTextField:
            addressTitleLabel.textColor = color
        default: break
        }
    }
}
