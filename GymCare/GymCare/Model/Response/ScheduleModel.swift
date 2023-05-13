//
//  ScheduleModel.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 11/03/2023.
//

import Foundation

// MARK: - DataClass
class ScheduleModel: Codable {
    var schedules: [Schedule]?

    init() {}

    init(schedules: [Schedule]?) {
        self.schedules = schedules
    }
}

// MARK: - Schedule
class Schedule: Codable {
    var id: Int?
    var date: [DateElementSchedule]?
    var trainer: Trainer?
    var scheduleClass: Class?
    var address: Address?
    var time: String?
    var day: String?
    var start_date: String?
    var end_date: String?
    var change_number: Int?
    var date_id: Int?
    var time_id: Int?

    enum CodingKeys: String, CodingKey {
        case id, date, trainer, address, time, day, start_date, end_date,
             change_number, date_id, time_id
        case scheduleClass = "class"
    }

    init(id: Int?, date: [DateElementSchedule]?, trainer: Trainer?, scheduleClass: Class?) {
        self.id = id
        self.date = date
        self.trainer = trainer
        self.scheduleClass = scheduleClass
    }
}

class DateSchedule {
    var id: Int?
    var date: [DateElement]?
    var trainer: Trainer?
    var scheduleClass: Class?
}
