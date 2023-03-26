//
//  OtherViewModel.swift
//  SchoolUpTeacher
//
//  Created by Nguyen Ha on 16/01/2023.
//

import Foundation

final class OtherViewModel: BaseViewModel {
    
    func callApiLogout(completion: @escaping (Bool, String?) -> Void) {
        self.repository.logout { status, msg in
            completion(status, msg)
        }
    }
}
