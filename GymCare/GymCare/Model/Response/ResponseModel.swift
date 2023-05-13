//
//  ResponseModel.swift
//  SchoolUpTeacher
//
//  Created by Truong Nguyen Huu on 28/12/2022.
//

import Foundation

class ResponseModel<T: Any & Codable>: Codable {

    var data: T?
    var message: String?
    var status: Bool?
//    var meta: MetaResponse?

    required init(from decoder: Decoder) throws {
        let map = try decoder.container(keyedBy: CodingKeys.self)
        do {
            let data = try map.decode(T.self, forKey: .data)
            self.data = data
        } catch {
            debugPrint("Parse Codable error:")
            debugPrint(error)
        }
        self.message = try? map.decode(String.self, forKey: .message)
        self.status = try? map.decode(Bool.self, forKey: .status)
//        self.meta = try? map.decode(MetaResponse.self, forKey: .meta)
    }

//    func getMessage() -> String? {
//        if let message = message, message.count > 0 {
//            return message[0]
//        }
//        return nil
//    }

    private enum CodingKeys: String, CodingKey {
        case data
        case message = "messages"
        case status = "success"
//        case meta
    }
}

class ResponsePaymentModel<T: Any & Codable>: Codable {

    var data: T?
    var message: String?
    var code: String?
//    var meta: MetaResponse?

    required init(from decoder: Decoder) throws {
        let map = try decoder.container(keyedBy: CodingKeys.self)
        do {
            let data = try map.decode(T.self, forKey: .data)
            self.data = data
        } catch {
            debugPrint("Parse Codable error:")
            debugPrint(error)
        }
        self.message = try? map.decode(String.self, forKey: .message)
        self.code = try? map.decode(String.self, forKey: .code)
//        self.meta = try? map.decode(MetaResponse.self, forKey: .meta)
    }

//    func getMessage() -> String? {
//        if let message = message, message.count > 0 {
//            return message[0]
//        }
//        return nil
//    }

    private enum CodingKeys: String, CodingKey {
        case data
        case message
        case code
//        case meta
    }
}

class ResponseModelArray<T: Any & Codable>: Codable {

    var data: [T]?
    var message: [String]?
    var status: Bool?
    var meta: MetaResponse?

    required init(from decoder: Decoder) throws {
        let map = try decoder.container(keyedBy: CodingKeys.self)
        do {
            let data = try map.decode([T].self, forKey: .data)
            self.data = data
        } catch {
            debugPrint("Parse Codable error:")
            debugPrint(error)
        }
        self.message = try? map.decode([String].self, forKey: .message)
        self.status = try? map.decode(Bool.self, forKey: .status)
        self.meta = try? map.decode(MetaResponse.self, forKey: .meta)
    }

    func getMessage() -> String? {
        if let message = message, message.count > 0 {
            return message[0]
        }
        return nil
    }

    private enum CodingKeys: String, CodingKey {
        case data
        case message
        case status
        case meta
    }
}
