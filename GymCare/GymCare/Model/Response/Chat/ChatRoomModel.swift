//
//  ChatRoomModel.swift
//  SchoolUp
//
//  Created by Truong Nguyen Huu on 16/02/2023.
//

import Foundation

class ChatRoomModel: Codable {

    var id: Int?
    var ownerType: Int?
    var insDatetime: String?
    var status: Int?
    var name: String?
    var content: String?
    var readFlag: Int?
    var owner: OwnerDetail?
    var messages: [MessageModel]?

    private enum CodingKeys: String, CodingKey {
        case id
        case ownerType = "owner_type"
        case insDatetime = "ins_datetime"
        case status
        case name
        case content
        case readFlag = "read_flag"
        case owner
        case messages
    }

    func isRead() -> Bool {
        return readFlag == 1
    }

}

class OwnerDetail: Codable {

    var id: Int?
    var gender: String?
    var name: String?
    var avatar: String?
    var info: String?

    private enum CodingKeys: String, CodingKey {
        case id
        case gender
        case name
        case avatar
        case info
    }

}
