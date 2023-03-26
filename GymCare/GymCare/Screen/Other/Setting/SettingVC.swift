//
//  SettingVC.swift
//  SchoolUpTeacher
//
//  Created by Nguyen Ha on 11/01/2023.
//

import UIKit

class SettingVC: BaseViewController {

    enum TagButton: Int {
        case notifi
        case language
        case policy
    }

    @IBOutlet weak var notiLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var policyLabel: UILabel!
    @IBOutlet weak var notiSwitch: UISwitch!

    private let viewModel = SettingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func onClickBack(_ sender: Any) {
        self.backScreen()
    }

}
