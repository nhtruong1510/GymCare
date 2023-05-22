//
//  PaymentVC.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 24/02/2023.
//

import UIKit
//import zpdk

class PaymentVC1: BaseViewController {
    
    @IBOutlet private weak var avatarView: AvatarView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var dayLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var expiredLabel: UILabel!
    @IBOutlet private weak var trainerLabel: UILabel!
    @IBOutlet private weak var trainerView: UIView!
    @IBOutlet private weak var amountLabel: UILabel!
    
    private let viewModel: PaymentViewModel = PaymentViewModel()
    
    var address = Address()
    var classModel = ClassModel()
    var param = ScheduleParamObject()
    var trainer: Trainer?
    private var paymentId: Int = 0
    private let userInfo = ServiceSettings.shared.userInfo
    private var sumMoney: Int = 0
    private var token: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        fillData()
    }
    
    private func configUI() {
        cutomNavi.onClickBack = { [weak self] in
            guard let `self` = self else { return }
            self.backScreen()
        }
        getListPayment()
        NotificationCenter.default.addObserver(self, selector: #selector(self.createPayment), name: .RELOAD_PAYMENT_SCREEN, object: nil)

    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .RELOAD_PAYMENT_SCREEN, object: nil)

    }
    
    private func getListPayment() {
        viewModel.callApiGetPayment(customerId: castToInt(userInfo?.id)) { [weak self] result, error in
            guard let `self` = self else { return }
            if let error = error {
                AlertVC.show(viewController: self, msg: error)
                return
            }
            if let notifications = result?.payments {
                self.paymentId = notifications.count
            }
//            self.refreshControl.endRefreshing()
        }
    }
    
    private func fillData() {
        avatarView.setupAvatarView(avatar: userInfo?.avatar, gender: userInfo?.gender)
        nameLabel.text = userInfo?.name
        addressLabel.text = address.address
        dayLabel.text = param.day
        timeLabel.text = param.time
        if let trainer = trainer {
            trainerLabel.text = trainer.name
            trainerView.isHidden = false
        }
        let start_date = formatDateString(dateString: castToString(param.start_date), Constants.DATE_PARAM_FORMAT, Constants.DATE_FORMAT)
        let end_date = formatDateString(dateString: castToString(param.end_date), Constants.DATE_PARAM_FORMAT, Constants.DATE_FORMAT)
        expiredLabel.text = castToString(start_date) + " - " + castToString(end_date)
        let sumMonth = viewModel.getSumMonth(fromDate: castToString(start_date),
                                             toDate: castToString(end_date))
        sumMoney = castToInt(param.money) * sumMonth
        amountLabel.text = castToString(param.money).formatMoney()  + "đ" + "*" + castToString(sumMonth) + " tháng = " + castToString(sumMoney).formatMoney() + " VNĐ"
//        if param.trainer_id != nil {
//            let sumSession = viewModel.getSumSession(fromDate: castToString(start_date),
//                                                     toDate: castToString(end_date),
//                                                     day: castToString(param.day))
//            sumMoney = castToInt(param.money) * sumSession
//            amountLabel.text = castToString(param.money).formatMoney()  + "đ" + "*" + castToString(sumSession) + " buổi = " + castToString(sumMoney).formatMoney() + " VNĐ"
//        } else {
//
//        }
        param.money = sumMoney
        //        param.start_date = formatDateString(dateString: castToString(param.start_date), Constants.DATE_FORMAT, Constants.DATE_PARAM_FORMAT)
        //        param.end_date = formatDateString(dateString: castToString(param.end_date), Constants.DATE_FORMAT, Constants.DATE_PARAM_FORMAT)
        param.method = 0
//        viewModel.setTokenZLP(amount: castToString(sumMoney)) { token in
//            self.token = token
//        }
    }
    
    @objc func createPayment() {
        self.viewModel.createSchedule(param: self.param) { success, msg in
            if success {
                AlertVC.show(viewController: self, msg: msg) {
                    self.backToRootScreen()
                }
            } else {
                AlertVC.show(viewController: self, msg: msg)
            }
        }
    }
    
    func installSandbox() {
        let alert = UIAlertController(title: "Info", message: "Please install ZaloPay", preferredStyle: .alert)
        let installLink = "https://stcstg.zalopay.com.vn/ps_res/ios/enterprise/sandboxmer/external/5.8.0/install.html"

        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
            
        }

        let installAction = UIAlertAction(title: "Install App", style: .default) { (action) in
            guard let url = URL(string: installLink) else {
                return
            }

            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        
        alert.addAction(cancelAction)
        alert.addAction(installAction)
        self.present(alert, animated: true, completion: nil)
    }

    func installZalo() {
        let alert = UIAlertController(title: "Info", message: "Please install Zalo", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
        }
        let installAction = UIAlertAction(title: "Install App", style: .default) { (action) in
//            ZaloPaySDK.sharedInstance()?.navigateToZaloStore()
        }
        alert.addAction(cancelAction)
        alert.addAction(installAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func onPayClick(_ sender: Any) {
        let vnp_ExpireDate = Date().addingTimeInterval(3600).toString(Constants.DATE_TIME_FORMAT_IMAGE) ?? ""
        let vnp_Amount = castToInt(param.money) * 100

        self.viewModel.check(vnp_Amount: vnp_Amount, vnp_ExpireDate: vnp_ExpireDate) { msg, data in
            if msg == "success" {
                self.openSDK(paymentUrl: castToString(data))

            } else {
                AlertVC.show(viewController: self, msg: msg)
            }
        }
//        ZaloPaySDK.sharedInstance()?.paymentDelegate = self
//        ZaloPaySDK.sharedInstance()?.payOrder(token)
    }
    
    private func openSDK(paymentUrl: String) {
        //  Converted to Swift 5.5 by Swiftify v5.5.24623 - https://swiftify.com/
        //các thông số dưới đây là demo
        //vui lòng đọc kỹ comment của từng variable một
        let fromVC = self //bắt buộc
        let scheme = "gymcare" //bắt buộc, tên scheme bạn tự đặt theo app
        let isSandbox = false //bắt buộc, YES <=> môi trường test, NO <=> môi trường live
        let paymentUrl = paymentUrl //@"https://sandbox.vnpayment.vn/tryitnow/Home/CreateOrder"; //bắt buộc, VNPAY cung cấp
        let tmn_code = "GJU252Q5" //bắt buộc, VNPAY cung cấp
        let backAction = true //bắt buộc, YES <=> bấm back sẽ thoát SDK, NO <=> bấm back thì trang web sẽ back lại trang trước đó, nên set là YES, nên set là YES, vì trang thanh toán không nên cho người dùng back về trang trước
        let backAlert = "" //không bắt buộc, thông báo khi người dùng bấm back
        let title = "VNPAY" //bắt buộc, title của trang thanh toán
        let titleColor = "#000000" //bắt buộc, màu của title
        let beginColor = "#FFFFFF" //bắt buộc, màu của background title
        let endColor = "#FFFFFF" //bắt buộc, màu của background title
        let iconBackName = "ic_back 1" //bắt buộc, icon back
        
        show(
            fromVC: fromVC,
            scheme: scheme,
            isSandbox: isSandbox,
            paymentUrl: paymentUrl,
            tmn_code: tmn_code,
            backAction: backAction,
            backAlert: backAlert,
            title: title,
            titleColor: titleColor,
            beginColor: beginColor,
            endColor: endColor,
            iconBackName: iconBackName)
    }
    
    //  Converted to Swift 5.5 by Swiftify v5.5.24623 - https://swiftify.com/
    func show(
        fromVC: UIViewController?,
        scheme: String?,
        isSandbox: Bool,
        paymentUrl: String?,
        tmn_code: String?,
        backAction: Bool,
        backAlert: String?,
        title: String?,
        titleColor: String?,
        beginColor: String?,
        endColor: String?,
        iconBackName: String?
    ) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("SDK_COMPLETED"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.sdkAction(_:)), name: NSNotification.Name("SDK_COMPLETED"), object: nil)
        if let fromVC = fromVC {
            DispatchQueue.main.async {
                CallAppInterface.setHomeViewController(fromVC)
            }
        }
        if let scheme = scheme {
            CallAppInterface.setSchemes(scheme)
        }
        CallAppInterface.setIsSandbox(isSandbox)
        if let appBackAlert = backAlert {
            CallAppInterface.setAppBackAlert(appBackAlert)
        }
        CallAppInterface.setEnableBackAction(backAction)
        if let paymentUrl = paymentUrl,
           let title = title,
           let iconBackName = iconBackName,
           let beginColor = beginColor,
           let endColor = endColor,
           let titleColor = titleColor,
           let tmn_code = tmn_code {
            CallAppInterface.showPushPaymentwithPaymentURL(paymentUrl,
                                                           withTitle: title,
                                                           iconBackName: iconBackName,
                                                           beginColor: beginColor,
                                                           endColor: endColor,
                                                           titleColor: titleColor,
                                                           tmn_code: tmn_code)
        }
    }
    
    //  Converted to Swift 5.5 by Swiftify v5.5.24623 - https://swiftify.com/
    @objc func sdkAction(_ notification: Notification?) {
        let name = notification?.name.rawValue ?? ""
        if name.isEqual("SDK_COMPLETED") {

            let actionValue = (notification?.object as? NSObject)?.value(forKey: "Action") as? String

            print("actionValue = \(actionValue ?? "")")

            if "AppBackAction" == actionValue {
                //Người dùng nhấn back từ sdk để quay lại

                return
            }
            if "CallMobileBankingApp" == actionValue {
                //Người dùng nhấn chọn thanh toán qua app thanh toán (Mobile Banking, Ví...)
                //lúc này app tích hợp sẽ cần lưu lại cái PNR, khi nào người dùng mở lại app tích hợp với cheme thì sẽ gọi kiểm tra trạng thái thanh toán của PNR Đó xem đã thanh toán hay chưa.

                return
            }
            if "WebBackAction" == actionValue {
                //Người dùng nhấn back từ trang thanh toán thành công khi thanh toán qua thẻ khi gọi đến http://sdk.merchantbackapp

                return
            }
            if "FaildBackAction" == actionValue {
                //giao dịch thanh toán bị failed

                return
            }
            if "SuccessBackAction" == actionValue {
                //thanh toán thành công trên webview

                return
            }
        }
    }
    
}

//extension PaymentVC: ZPPaymentDelegate {
//    func paymentDidSucceeded(_ transactionId: String!, zpTranstoken: String!, appTransId: String!) {
//            createPayment()
//            // Handle Success
//    }
//
//    func paymentDidCanceled(_ zpTranstoken: String!, appTransId: String!) {
//        // Handle Cancel
//    }
//
//    func paymentDidError(_ errorCode: ZPPaymentErrorCode, zpTranstoken : String!, appTransId: String!) {
//        print("Thanh toán thất bại, error: \(errorCode.rawValue)")
//        // Handle error
//    }
//}
