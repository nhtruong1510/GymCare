//
//  AddressViewModel.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 10/03/2023.
//

import Foundation

final class AddressViewModel: BaseViewModel {

    func callApiGetAddress(classId: Int, completion: @escaping (AddressModel?, String?) -> Void) {
        self.repository.getAddress(classId: classId) { data, msg in
            completion(data, msg)
        }
    }
}
