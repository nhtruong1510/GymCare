//
//  NotifiDetailVC.swift
//
//

import UIKit

class NotifiDetailVC: BaseViewController {

    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var alertImageView: UIImageView!
    @IBOutlet private weak var updateButton: UIButton!

    @IBOutlet private var avatarView: AvatarView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var addressLabel: UILabel!
    @IBOutlet private var dayLabel: UILabel!
    @IBOutlet private var timeLabel: UILabel!
    @IBOutlet private var expiredLabel: UILabel!

    var notify: NotifiObject = NotifiObject()
    private let viewModel = NotifiDetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        getDetailNoti(noti: notify)
        fillData()
    }

    private func configUI() {
        cutomNavi.onClickBack = { [weak self] in
            guard let `self` = self else { return }
            self.backScreen()
        }
    }

    private func fillData() {
        dateLabel.text = notify.date_create
        contentLabel.text = notify.content
        let isRead = castToInt(notify.is_read) == 1
        alertImageView.image = isRead ? #imageLiteral(resourceName: "ic_read") : #imageLiteral(resourceName: "ic_unread")
        
        avatarView.setupAvatarView(avatar: notify.trainer?.avatar, gender: notify.trainer?.gender)
        nameLabel.text = notify.trainer?.name
        addressLabel.text = notify.address?.address
        dayLabel.text = notify.day
        timeLabel.text = notify.time
        expiredLabel.text = castToString(notify.start_date) + " - " + castToString(notify.end_date)
        if let id = notify.id {
            updateStatusNoti(id: (id))
        }
//        param.start_date = formatDateString(dateString: castToString(param.start_date), Constants.DATE_FORMAT, Constants.DATE_PARAM_FORMAT)
//        param.end_date = formatDateString(dateString: castToString(param.end_date), Constants.DATE_FORMAT, Constants.DATE_PARAM_FORMAT)
    }

    private func updateStatusNoti(id: Int) {
        viewModel.updateStatusNoti(notiId: id) { [weak self] in
            guard let `self` = self else { return }
//            if status {
////                self.getDetailNoti(id: id)
//            } else {
//                UIAlertController.showDefaultAlert(andMessage: msg)
//            }
        }
    }

    private func getDetailNoti(noti: NotifiObject) {
        guard let id = noti.id else { return }
//        viewModel.getDetailNotifi(id: id) { [weak self] inforNoti, status, msg in
//            guard let `self` = self else { return }
//            if status {
//                self.notify = inforNoti
//                self.fillData()
//                self.updateStatusNoti(id: id)
//            } else {
//                UIAlertController.showDefaultAlert(andMessage: msg)
//            }
//        }
    }

    private func callApiGetDetail(lendingId: String, formType: Int, isEditData: Bool) {
//        viewModel.getDetailForm6(formId: lendingId) { [weak self] data, msg in
//            guard let `self` = self else { return }
//            if let msg = msg {
//                UIAlertController.showDefaultAlert(andMessage: msg)
//                return
//            }
//            let vc = Form912Step1VC()
//            vc.formType6 = data
//            vc.isEditData = isEditData
//            vc.alert = castToString(self.notify.message)
//            self.nextScreen(ctrl: vc)
//        }
    }
    
    @IBAction private func createPayment() {
        ConfirmVC.show(viewController: self, title: "Xác nhận", msg: "Bạn có chắc chắn thực hiện thao tác này?") {
//            self.viewModel.createSchedule(param: self.param) { success, msg in
//                if success {
//                    AlertVC.show(viewController: self, msg: msg) {
//                        self.backScreen()
//                    }
//                } else {
//                    AlertVC.show(viewController: self, msg: msg)
//                }
//            }
        }
    }
}


