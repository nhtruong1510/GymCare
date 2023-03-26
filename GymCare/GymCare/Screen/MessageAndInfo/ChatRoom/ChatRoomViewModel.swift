//
//  ChatRoomViewModel.swift
//  SchoolUp
//
//  Created by Truong Nguyen Huu on 15/02/2023.
//

import UIKit

final class ChatRoomViewModel: BaseViewModel {
    
    func getChatDetail(id: Int, page: Int, completion: @escaping (TopicDetailModel?, String?) -> Void) {
        self.repository.getChatDetail(id: id, page: page) { data, msg in
            completion(data, msg)
        }
    }

    func getReloadChatDetail(id: Int, time: String, completion: @escaping (TopicDetailModel?, String?) -> Void) {
        self.repository.getReloadChatDetail(id: id, time: time) { data, msg in
            completion(data, msg)
        }
    }

    func sendChatMessage(id: Int, content: String, image: UIImage?, completion: @escaping (Bool, String?) -> Void) {
        self.repository.sendChatMessage(id: id, content: content, image: image) { status, msg in
            completion(status, msg)
        }
    }
    
    func filterDupplicateMessages(messages: [MessageModel]) -> [MessageModel] {
        var buffer = [MessageModel]()
        for message in messages where !buffer.contains(where: {$0.id == message.id}) {
            buffer.append(message)
        }
        return buffer
    }

}
