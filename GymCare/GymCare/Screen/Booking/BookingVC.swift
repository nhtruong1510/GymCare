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
    @IBOutlet private weak var changeNumberLabel: UILabel!

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
            let times = self.listTime.sorted(by: {
                castToInt($0.name?.components(separatedBy: ":")[0]) <
                    castToInt($1.name?.components(separatedBy: ":")[0])
            })
            self.showPopupSearchData(title: "Chọn thời điểm tập",
                                     dataSource: times,
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
        changeNumberLabel.text = "Bạn còn \(castToString(4-castToInt(schedule?.change_number))) lần thay đổi lịch tập này"
        changeNumberLabel.isHidden = schedule == nil || schedule?.trainer == nil
    }

    private func fillData() {
        guard let schedule = schedule else { return }
        fromDatePickerView.editingIsAllow = false
        toDatePickerView.editingIsAllow = false
        fromDatePickerView.value = formatDateString(dateString: castToString(schedule.start_date), Constants.DATE_PARAM_FORMAT, Constants.DATE_FORMAT)
        toDatePickerView.value = formatDateString(dateString: castToString(schedule.end_date), Constants.DATE_PARAM_FORMAT, Constants.DATE_FORMAT)
        timePickerView.value = schedule.time
        self.dateAddress = self.address.addressClass?.date?.filter({$0.day == schedule.day}).first
        listTime = self.viewModel.setListRegion(data: self.dateAddress?.time)
        day = RegionObject(id: schedule.date_id, name: schedule.day)
        dayPickerView.value = schedule.day
        choosePTView.isHidden = schedule.trainer == nil
        self.avatarView.setupAvatarView(avatar: schedule.trainer?.avatar, gender: schedule.trainer?.gender)
        self.namePTLabel.text = schedule.trainer?.name
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
                                        date_id: day?._id,
                                        time_id: time?._id,
                                        money: address.addressClass?.money,
                                        method: 0, status: status)
        param.start_date = formatDateString(dateString: castToString(param.start_date), Constants.DATE_FORMAT, Constants.DATE_PARAM_FORMAT)
        param.end_date = formatDateString(dateString: castToString(param.end_date), Constants.DATE_FORMAT, Constants.DATE_PARAM_FORMAT)
        if (trainer != nil) || schedule?.trainer != nil {
            param.is_create = schedule == nil ? 0 : 1
            param.schedule_id = schedule?.id
            if day == nil {
                param.date_id = schedule?.date_id
            }
            if time == nil {
                param.time_id = schedule?.time_id
            }
            ConfirmVC.show(viewController: self, title: "Xác nhận", msg: "Bạn có chắc chắn thực hiện thao tác này?") {
                self.viewModel.createNoti(param: param) { success, msg in
                    if success {
                        AlertVC.show(viewController: self, msg: msg) {
                            self.backToRootScreen()
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
        let vc = PaymentVC1()
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

