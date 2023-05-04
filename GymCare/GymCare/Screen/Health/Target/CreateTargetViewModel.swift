//
//  CreateTargetViewModel.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 26/02/2023.
//

import Foundation

final class CreateTargetViewModel: BaseViewModel {
    final var listRun: [RegionObject] = [RegionObject(id: 1, code: "1", name: "")]

    func updateTarget(param: TargetParamObject, completion: @escaping (Bool, String?) -> Void) {
        self.repository.updateTarget(param: param) { success, msg in
            completion(success, msg)
        }
    }

    func createTarget(param: TargetParamObject, completion: @escaping (Bool, String?) -> Void) {
        self.repository.createTarget(param: param) { success, msg in
            completion(success, msg)
        }
    }
}
