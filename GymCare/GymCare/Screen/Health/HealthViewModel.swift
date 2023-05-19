//
//  HealthViewModel.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 04/04/2023.
//

import Foundation

final class HealthViewModel: BaseViewModel {
    func callApiGetTrainer(customerId: Int, completion: @escaping (TargetModel?, String?) -> Void) {
        self.repository.getTarget(customerId: customerId) { data, msg in
            completion(data, msg)
        }
    }
    
    func createOrUpdateHealth(param: TargetParamObject, completion: @escaping (Bool, String?) -> Void) {
        self.repository.createOrUpdateHealth(param: param) { success, msg in
            completion(success, msg)
        }
    }
    
    func callApiGetHealth(completion: @escaping ([TargetHealth]?, String?) -> Void) {
        self.repository.getHealth(showLoading: false) { data, msg in
            completion(data, msg)
        }
    }
    
    func setListData() -> [TargetList] {
        var listTarget: [TargetList] = []
        for _ in 0...7 {
            listTarget.append(TargetList())
        }
        return listTarget
    }
}
