//
//  PaymentModel.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 26/03/2023.
//

import Foundation

// MARK: - DataClass
struct PaymentModel: Codable {
    var payments: [Payment]?
}

// MARK: - Payment
struct Payment: Codable {
    var id: Int?
    var date: String?
    var date_create: String?
    var trainer: Trainer?
    var paymentClass: Class?
    var address: Address?
    var day, time: String?
    var money: Int?

    enum CodingKeys: String, CodingKey {
        case id, date, trainer
        case paymentClass = "class"
        case address, day, time, money, date_create
    }
}
