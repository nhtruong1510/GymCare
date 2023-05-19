//
//  CreateTargetVC.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 25/02/2023.
//

import UIKit

class CreateTargetVC: BaseViewController {

    @IBOutlet private weak var runFieldView: InputFieldView!
    @IBOutlet private weak var sleepPickerView: InputFieldView!
    @IBOutlet private weak var roadFieldView: InputFieldView!

    private let viewModel = CreateTargetViewModel()
    private let userInfo = ServiceSettings.shared.userInfo

    var target: Target?
    var onClick: (()->Void)?
    private let userHealthProfile = UserHealthProfile()

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        touchOut()
        self.fillData()
    }

    private func fillData() {
        DispatchQueue.main.async {
            self.updateHealthInfo()

        }
    }

    private func configUI() {
        cutomNavi.onClickBack = { [weak self] in
            guard let `self` = self else { return }
            self.backScreen()
        }

        runFieldView.editingCallBack = { [weak self] value in
            guard let `self` = self else { return }
            
        }
        
        roadFieldView.editingCallBack = { [weak self] value in
            guard let `self` = self else { return }
            
        }
        
        guard let target = target else { return }
        runFieldView.value = castToString(target.walkNumber)
        sleepPickerView.value = castToString(target.sleep)
        roadFieldView.value = castToString(target.distance)

    }

    private func updateHealthInfo() {
      loadAndDisplayAgeSexAndBloodType()
//      loadAndDisplayMostRecentWeight()
//      loadAndDisplayMostRecentHeight()
    }
    
    private func loadAndDisplayAgeSexAndBloodType() {
      
      do {
        let userAgeSexAndBloodType = try ProfileDataStore.getAgeSexAndBloodType()
        userHealthProfile.age = userAgeSexAndBloodType.age
        userHealthProfile.biologicalSex = userAgeSexAndBloodType.biologicalSex
        userHealthProfile.bloodType = userAgeSexAndBloodType.bloodType
        updateLabels()
      } catch let error {
        print(error)
      }
    }
    
    private func updateLabels() {
      
//      if let age = userHealthProfile.age {
//          runFieldView.value = "\(age)"
//      }
//
//      if let biologicalSex = userHealthProfile.biologicalSex {
//        biologicalSexLabel.text = biologicalSex.stringRepresentation
//      }
//
//      if let bloodType = userHealthProfile.bloodType {
//        bloodTypeLabel.text = bloodType.stringRepresentation
//      }
//
//      if let weight = userHealthProfile.weightInKilograms {
//        let weightFormatter = MassFormatter()
//        weightFormatter.isForPersonMassUse = true
//        weightLabel.text = weightFormatter.string(fromKilograms: weight)
//      }
//
//      if let height = userHealthProfile.heightInMeters {
//        let heightFormatter = LengthFormatter()
//        heightFormatter.isForPersonHeightUse = true
//        heightLabel.text = heightFormatter.string(fromMeters: height)
//      }
//
//      if let bodyMassIndex = userHealthProfile.bodyMassIndex {
//        bodyMassIndexLabel.text = String(format: "%.02f", bodyMassIndex)
//      }
    }
    
    @IBAction private func onClickSubmit(_ sender: UIButton) {
        let param = TargetParamObject(customer_id: userInfo?.id,
                                      distance: castToInt(roadFieldView.value),
                                      walk_number: castToInt(runFieldView.value),
                                      sleep: castToInt(sleepPickerView.value))
        if target != nil {
            ConfirmVC.show(viewController: self, title: "Xác nhận", msg: "Bạn có chắc chắn thực hiện thao tác này?") {
                self.viewModel.updateTarget(param: param) { success, msg in
                    if success {
                        NotificationCenter.default.post(name: .RELOAD_HEALTH_SCREEN, object: nil)
                        AlertVC.show(viewController: self, msg: msg) {
                            self.onClick?()
                            self.backScreen()
                        }
                    } else {
                        AlertVC.show(viewController: self, msg: msg)
                    }
                }
            }
        } else {
            ConfirmVC.show(viewController: self, title: "Xác nhận", msg: "Bạn có chắc chắn thực hiện thao tác này?") {
                self.viewModel.createTarget(param: param) { success, msg in
                    if success {
                        NotificationCenter.default.post(name: .RELOAD_HEALTH_SCREEN, object: nil)
                        AlertVC.show(viewController: self, msg: msg) {
                            self.onClick?()
                            self.backScreen()
                        }
                    } else {
                        AlertVC.show(viewController: self, msg: msg)
                    }
                }
            }
        }
    }
}
