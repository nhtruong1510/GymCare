//
//  LoginViewModel.swift
//  GymCare
//
//  Created by Nguyễn Hà on 29/12/2022.
//

import Foundation

final class LoginViewModel: BaseViewModel {

    func callApiLogin(email: String?, pass: String?, completion: @escaping (_ result: Bool, _ error: String?) -> Void) {
        if let error = validate(email: email, pass: pass) {
            return
        }
        self.repository.callApiLogin(email: email!, pass: pass!) { userObject, msgError in
            if let userObject = userObject {
                ServiceSettings.shared.userInfo = userObject
                completion(true, msgError)
            } else {
                completion(false, msgError)
            }
        }
    }

    func validate(email: String?, pass: String?) -> String? {
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
        return nil
    }

}
