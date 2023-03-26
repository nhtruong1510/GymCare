//
//  ContentProgramVC.swift
//  SchoolUp
//
//  Created by Truong Nguyen Huu on 16/02/2023.
//

import UIKit

class ContentProgramVC: BaseViewController {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var registerLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var forLabel: UILabel!
    @IBOutlet private weak var benefitLabel: UILabel!

    var classModel: Class = Class()

    override func viewDidLoad() {
        super.viewDidLoad()
        fillData()
    }

    private func fillData() {
        imageView.loadImage(urlString: classModel.thump_img)
        titleLabel.text = classModel.name
        if let current = classModel.currentParticipate, let max = classModel.maxParticipate {
            registerLabel.text = "Đã đăng ký: " + castToString(current) + "/" + castToString(max)
        } else {
            registerLabel.text = ""
        }
        descriptionLabel.text = classModel.description
//        forLabel.text =
        benefitLabel.text = classModel.benefit
    }

    @IBAction private func onClickBack() {
        self.backScreen()
    }
    
    @IBAction private func onClickRegister() {
        let vc = AddressVC()
        vc.classId = classModel.id
        self.nextScreen(ctrl: vc)
    }
}
