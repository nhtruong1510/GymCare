//
//  TopicModel.swift
//  SchoolUpTeacher
//
//  Created by Nguyen Ha on 10/01/2023.
//

import Foundation

// MARK: - DataClass
struct TopicModel: Codable {
    var chats: [Chat]?
}

// MARK: - Chat
struct Chat: Codable {
    var id: Int?
    var trainer: Trainer?
    var isReadCustomer: Int?
    var insDatetime, lastMessage: String?

    enum CodingKeys: String, CodingKey {
        case id, trainer
        case isReadCustomer = "is_read_customer"
        case insDatetime = "ins_datetime"
        case lastMessage = "last_message"
    }
    
    func isRead() -> Bool {
        return isReadCustomer == 1
    }
}

