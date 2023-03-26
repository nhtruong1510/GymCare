//
//  NotificationModel.swift
//  GymCareForTrainer
//
//  Created by Truong Nguyen Huu on 16/03/2023.
//

import Foundation

// MARK: - DataClass
class NotificationModel: Codable {
    var notifications: [NotifiObject]?

    init(notifications: [NotifiObject]?) {
        self.notifications = notifications
    }
}

// MARK: - Schedule
class NotifiObject: Codable {
    var id: Int?
    var content: String?
    var is_read: Int?
    var date_create: String?
    var customer: UserModel?
    var trainer: UserModel?
    var classModel: Class?
    var address: Address?
    var day: String?
    var time: String?
    var end_date: String?
    var start_date: String?
    var status: Int?
    var money: Int?
    var schedule_id: Int?

    enum CodingKeys: String, CodingKey {
        case id, content, is_read, date_create, start_date, end_date, time, day, address, customer, status, trainer, money, schedule_id
        case classModel = "class"
    }

//    init(id: Int?, date: [DateElementSchedule]?, trainer: Trainer?, scheduleClass: Class?) {
//        self.id = id
//        self.date = date
//        self.trainer = trainer
//        self.scheduleClass = scheduleClass
//    }
}
