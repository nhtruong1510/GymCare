//
//  RegisterViewModel.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 17/04/2023.
//


import Foundation

final class RegisterViewModel: BaseViewModel {

    func callApiRegister(email: String?, name: String?, pass: String?, confirmPass: String?, completion: @escaping (_ result: Bool, _ error: String?) -> Void) {
        if let error = validate(email: email, pass: pass, confirmPass: confirmPass) {
            return
        }
        self.repository.callApiRegister(phone: email!, name: name!, pass: pass!) { success, msgError in
            completion(success, msgError)
        }
    }

    func validate(email: String?, pass: String?, confirmPass: String?) -> String? {
        if castToString(email).isEmpty {
            return "Email không được để trống"
        }
        // kiểm tra chuỗi chứa số ko
        if castToString(email).isNumeric {
            if !castToString(email).isValidPhoneSize() {
                return "Số điện thoại phải từ 9-11 kí tự"
            }
        } else {
            if !castToString(email).isValidEmail() {
                return "Sai định dạng email"
            }
        }
        if castToString(pass).isEmpty {
            return "Mật khẩu không được để trống"
        }
        if castToString(pass) != castToString(confirmPass) {
            return "Mật khẩu và xác nhận mật khẩu không trùng khớp"
        }
        return nil
    }

}
