//
//  UserModel.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 06/03/2023.
//

import Foundation

// MARK: - DataClass
class TrainerModel: Codable {
    var rowsReturned: Int?
    var trainer: [Trainer]?

    enum CodingKeys: String, CodingKey {
        case rowsReturned = "rows_returned"
        case trainer
    }
}

// MARK: - Trainer
class Trainer: Codable {
    var id: Int?
    var name, email, phone: String?
    var avatar, birth, address: String?
    var gender: Int?
    var certificate, experience, workplace, specialize: String?
    
    init() {}
}

// MARK: - UserModel
class UserModel: Codable {
    var id: Int?
    var name, phone, email: String?
    var avatar: String?
    var address: String?
    var gender: Int?
    var birth: String?

    init(id: Int?, name: String?, phone: String?, email: String?,
         avatar: String?, address: String?, gender: Int?, birth: String?) {
        self.id = id
        self.name = name
        self.phone = phone
        self.email = email
        self.avatar = avatar
        self.address = address
        self.gender = gender
        self.birth = birth
    }
}
