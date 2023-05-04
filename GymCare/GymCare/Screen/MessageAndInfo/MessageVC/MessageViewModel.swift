//
//  MessageViewModel.swift
//  SchoolUpTeacher
//
//  Created by Nguyen Ha on 10/01/2023.
//

import Foundation

final class MessageViewModel: BaseViewModel {
    
    func getTopics(completion: @escaping (TopicModel?, String?) -> Void) {
        self.repository.getTopics(customerId: castToInt(ServiceSettings.shared.userInfo?.id)) { [weak self] data, msg in
            guard let `self` = self else { return }
            completion(data, msg)
        }
    }

}
