//
//  MessageViewModel.swift
//  SchoolUpTeacher
//
//  Created by Nguyen Ha on 10/01/2023.
//

import Foundation

final class MessageViewModel: BaseViewModel {

    private var totalTopics = 0
    var page = 1
    
    func getTopics(completion: @escaping (TopicModel?, String?) -> Void) {
        self.repository.getTopics(page: page) { [weak self] data, msg in
            guard let `self` = self else { return }
            self.page = castToInt(data?.total)
            completion(data, msg)
        }
    }

    func loadMore(topics: [TopicDetailModel] = []) -> Bool {
        if topics.count > 0 && topics.count < totalTopics {
            page += 1
            return true
        }
        return false
    }

}
