//
//  MessageViewModel.swift
//  GymCare
//
//

import Foundation

final class MessageViewModel: BaseViewModel {
    
    func getTopics(showLoading: Bool, completion: @escaping (TopicModel?, String?) -> Void) {
        self.repository.getTopics(showLoading: showLoading, customerId: castToInt(ServiceSettings.shared.userInfo?.id)) { data, msg in
            completion(data, msg)
        }
    }

}
