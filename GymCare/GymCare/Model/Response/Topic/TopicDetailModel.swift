//
//  TopicDetailModel.swift
//  SchoolUpTeacher
//
//  Created by Nguyen Ha on 10/01/2023.
//

import Foundation

class TopicDetailModel: Codable {

    var id: Int?
    var ownerType: Int?
    var insDatetime: String?
    var status: Int?
    var name: String?
    var content: String?
    var readFlag: Int?
    var owner: OwnerModel?
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

class MessageModel: Codable {

    var id: Int?
    var type: Int?
    var insDatetime: String?
    var content: String?
    var attachments: [AttachmentModel] = []
    var owner: OwnerModel?

    private enum CodingKeys: String, CodingKey {
        case id
        case type
        case insDatetime = "ins_datetime"
        case content
        case attachments
        case owner
    }

    func isOwner() -> Bool {
        return true//owner?.id == ServiceSettings.shared.parentInfo?.id
    }

}

class AttachmentModel: Codable {

    var id: Int?
    var title: String?
    var type: String?
    var sourceUrl: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case type
        case sourceUrl = "source_url"
    }

}

class OwnerModel: Codable {

    var id: Int?
    var gender: Int?
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
