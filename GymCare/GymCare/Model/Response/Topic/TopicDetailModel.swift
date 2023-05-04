//
//  TopicDetailModel.swift
//  SchoolUpTeacher
//
//  Created by Nguyen Ha on 10/01/2023.
//

import Foundation

// MARK: - DataClass
struct TopicDetailModel: Codable {
    var messages: [MessageModel]?
}

// MARK: - Message
struct MessageModel: Codable {
    var id: Int?
    var content: String?
    var is_customer: Int?
    var image: String?
    var insDatetime: String?

    enum CodingKeys: String, CodingKey {
        case id, content
        case is_customer
        case image
        case insDatetime = "ins_datetime"
    }
    
    func isCustomer() -> Bool {
        return is_customer == 1
    }
}
