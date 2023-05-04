//
//  EditProfileViewModel.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 18/04/2023.
//

import Foundation

final class EditProfileViewModel: BaseViewModel {
    
    func callApiEditProfile(param: UserModel?, completion: @escaping (_ result: Bool, _ error: String?) -> Void) {
        if let param = param {
            self.repository.callApiEditProfile(param: param) { success, msgError in
                completion(success, msgError)
            }
        }
    }
    
    func callApiGetUserDetail(id: Int?, completion: @escaping (UserModel?, String?) -> Void) {
        repository.getUserDetail(id: castToInt(id)) { data, msg in
            completion(data, msg)
        }
    }
}
