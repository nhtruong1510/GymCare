//
//  CreateTargetVC.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 25/02/2023.
//

import UIKit

class CreateTargetVC: BaseViewController {

    @IBOutlet private weak var runFieldView: InputFieldView!
    @IBOutlet private weak var sleepPickerView: InputPickerView!
    @IBOutlet private weak var roadFieldView: InputFieldView!

    private let viewModel = BookingViewModel()
    private let numberOfAdd = "01"
    private var districtCode: String? = nil
    private var address: RegionObject?
    private var day: RegionObject?
    private var time: RegionObject?

//    private let userInfo = ServiceSettings.shared.userInfo
    
    var isEditData: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
//        self.viewModel.getTaxDepartment()
        self.fillData()
    }

    private func fillData() {

    }

    private func getTaxAuthorByDepart(parentCode: String?) {
    }

    private func configUI() {
        cutomNavi.onClickBack = { [weak self] in
            guard let `self` = self else { return }
            self.backScreen()
        }

        runFieldView.editingCallBack = { [weak self] value in
            guard let `self` = self else { return }
            
        }

        sleepPickerView.onClickShowPopup = { [weak self] in
            guard let `self` = self else {
//                UIAlertController.showDefaultAlert(andMessage: "Vui lòng chọn cơ quan thuế cấp cục")
                return
            }
            
        }
        
        roadFieldView.editingCallBack = { [weak self] value in
            guard let `self` = self else { return }
            
        }
    }

    @IBAction private func onClickSubmit(_ sender: UIButton) {
        self.backScreen()
    }
}
