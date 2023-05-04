//
//  BookingVC.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 23/02/2023.
//

import UIKit

class BookingVC: BaseViewController {

    @IBOutlet private weak var namePickerView: InputFieldView!
    @IBOutlet private weak var addressPickerView: InputFieldView!
    @IBOutlet private weak var dayPickerView: InputPickerView!
    @IBOutlet private weak var timePickerView: InputPickerView!
    @IBOutlet private weak var fromDatePickerView: InputPickerView!
    @IBOutlet private weak var toDatePickerView: InputPickerView!
    @IBOutlet private weak var choosePTView: UIView!
    @IBOutlet private weak var avatarView: AvatarView!
    @IBOutlet private weak var namePTLabel: UILabel!

    private let viewModel = BookingViewModel()
    private var districtCode: String? = nil
    private var day: RegionObject?
    private var dateAddress: DateElement?
    private var time: RegionObject?
    private var expired: RegionObject?
    private var trainer: Trainer?
    private var listDay: [RegionObject] = []
    private var listTime: [RegionObject] = []
    private var listExpired: [RegionObject] = []

    var address: Address = Address()
    var schedule: Schedule?

    private let userInfo = ServiceSettings.shared.userInfo

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        self.fillData()
    }

    private func getTaxAuthorByDepart(parentCode: String?) {
    }

    private func configUI() {
        namePickerView.value = address.addressClass?.name
        cutomNavi.onClickBack = { [weak self] in
            guard let `self` = self else { return }
            self.backScreen()
        }
        
        addressPickerView.value = address.address
        self.listDay = viewModel.setListRegion(data: address.addressClass?.date)
        dayPickerView.onClickShowPopup = { [weak self] in
            guard let `self` = self, self.listDay.count > 0 else {
                return
            }
            self.showPopupSearchData(title: "Chọn ngày tập",
                                     dataSource: self.listDay,
                                     selectedData: self.day) { [weak self] data in
                guard let `self` = self else { return }
                self.day = data
                self.dateAddress = self.address.addressClass?.date?.filter({$0.id == self.day?._id}).first
                self.listTime = self.viewModel.setListRegion(data: self.dateAddress?.time)
                self.dayPickerView.value = data.name
                self.timePickerView.value = nil
                self.time = nil
                self.trainer = nil
            }
        }
        
        timePickerView.onClickShowPopup = {
            guard self.listTime.count > 0, self.day != nil else {
                AlertVC.show(viewController: self, msg: "Vui lòng chọn ngày tập")
                return
            }
            self.showPopupSearchData(title: "Chọn thời điểm tập",
                                     dataSource: self.listTime,
                                     selectedData: self.time) { [weak self] data in
                guard let `self` = self else { return }
                self.time = data
                self.timePickerView.value = data.name
                self.trainer = nil
                let time = self.dateAddress?.time?.filter({$0.id == data._id}).first
                guard let trainerId = time?.trainerId else { return }
                self.viewModel.callApiGetTrainer(trainerId: trainerId) { data, msg in
                    self.trainer = data
                    self.avatarView.setupAvatarView(avatar: self.trainer?.avatar, gender: self.trainer?.gender)
                    self.namePTLabel.text = self.trainer?.name
                    self.choosePTView.isHidden = false
                }
            }
        }
    }

    private func fillData() {
        if schedule != nil {
            fromDatePickerView.editingIsAllow = false
            toDatePickerView.editingIsAllow = false
            fromDatePickerView.value = formatDateString(dateString: castToString(schedule?.start_date), Constants.DATE_PARAM_FORMAT, Constants.DATE_FORMAT)
            toDatePickerView.value = formatDateString(dateString: castToString(schedule?.end_date), Constants.DATE_PARAM_FORMAT, Constants.DATE_FORMAT)
            timePickerView.value = schedule?.time
            dayPickerView.value = schedule?.day
            choosePTView.isHidden = schedule?.trainer == nil
            self.avatarView.setupAvatarView(avatar: schedule?.trainer?.avatar, gender: schedule?.trainer?.gender)
            self.namePTLabel.text = schedule?.trainer?.name
        }
//        timePickerView.value = timeSelected
//        if let date = address.addressClass?.date, date.count > 0 {
//            dayPickerView.value = date[0].day
//        }
    }
    
    @IBAction private func onClickSubmit(_ sender: UIButton) {
        let status = schedule == nil ? TypeStatus.create.rawValue : TypeStatus.update.rawValue
        let trainerId = trainer != nil ? trainer?.id : schedule?.trainer?.id

        let param = ScheduleParamObject(customer_id: userInfo?.id,
                                        address_id: address.id,
                                        class_id: address.addressClass?.id,
                                        trainer_id: trainerId,
                                        day: dayPickerView.value,
                                        start_date: fromDatePickerView.value,
                                        end_date: toDatePickerView.value,
                                        time: timePickerView.value,
                                        money: address.addressClass?.money,
                                        method: 0, status: status)
        param.start_date = formatDateString(dateString: castToString(param.start_date), Constants.DATE_FORMAT, Constants.DATE_PARAM_FORMAT)
        param.end_date = formatDateString(dateString: castToString(param.end_date), Constants.DATE_FORMAT, Constants.DATE_PARAM_FORMAT)
        if (trainer != nil) || schedule?.trainer != nil {
            param.is_create = schedule == nil ? 0 : 1
            param.schedule_id = schedule?.id
            ConfirmVC.show(viewController: self, title: "Xác nhận", msg: "Bạn có chắc chắn thực hiện thao tác này?") {
                self.viewModel.createNoti(param: param) { success, msg in
                    if success {
                        AlertVC.show(viewController: self, msg: msg) {
                            self.backScreen()
                        }
                    } else {
                        AlertVC.show(viewController: self, msg: msg)
                    }
                }
            }
            return
        }
        if let schedule = schedule {
            param.schedule_id = schedule.id
            ConfirmVC.show(viewController: self, title: "Xác nhận", msg: "Bạn có chắc chắn thực hiện thao tác này?") {
                self.viewModel.updateSchedule(param: param) { success, msg in
                    if success {
                        AlertVC.show(viewController: self, msg: msg) {
                            self.backScreen()
                        }
                    } else {
                        AlertVC.show(viewController: self, msg: msg)
                    }
                }
            }
            return
        }
        let vc = PaymentVC()
        vc.address = address
        vc.param = param
        self.nextScreen(ctrl: vc)
    }
    
    @IBAction private func onClickTrainer(_ sender: UIButton) {
        let vc = InfoTrainerVC()
        if let trainer = trainer {
            vc.trainer = trainer
        } else if let trainer = schedule?.trainer {
            vc.trainer = trainer
        }
        self.nextScreen(ctrl: vc)
    }
}

