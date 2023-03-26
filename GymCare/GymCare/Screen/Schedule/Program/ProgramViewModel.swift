//
//  ProgramViewModel.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 16/03/2023.
//

import Foundation

class ProgramViewModel: BaseViewModel {

    func callApiGetClass(classId: Int, completion: @escaping (ClassModel?, String?) -> Void) {
        self.repository.getClassInfo(classId: classId) { data, msg in
            completion(data, msg)
        }
    }
}

