//
//  LoginResponse.swift
//  GymCare
//
//

import Foundation

class LoginResponse: Codable {

    var id: Int?
    var email: String?
    var phone: String?
    var avatar: String?
    var name: String?

    private enum CodingKeys: String, CodingKey {
        case id
        case email
        case phone
        case avatar
        case name

    }

}
