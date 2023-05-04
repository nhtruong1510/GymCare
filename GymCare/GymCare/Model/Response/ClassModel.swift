//
//  ClassModel.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 06/03/2023.
//

import Foundation

// MARK: - ClassModel
class ClassModel: Codable {
    var rowsReturned: Int?
    var classes: [Class]?
    var schedules: [Schedule]?

    init() {}

    enum CodingKeys: String, CodingKey {
        case rowsReturned = "rows_returned"
        case classes
    }

    init(rowsReturned: Int?, classes: [Class]?) {
        self.rowsReturned = rowsReturned
        self.classes = classes
    }
}

// MARK: - Class
class Class: Codable {
    var id: Int?
    var date: [DateElement]?
    var name: String?
    var image: String?
    var maxParticipate, currentParticipate: Int?
    var description: String?
    var benefit: String?
    var endDate: String?
    var money: Int?
    var sumMonth: [SumMonth]?

    init() {}

    enum CodingKeys: String, CodingKey {
        case id
        case date, name
        case image
        case maxParticipate = "max_participate"
        case currentParticipate = "current_participate"
        case description, benefit, money
        case sumMonth = "sum_month"
    }

    init(date: [DateElement]?, name: String?, maxParticipate: Int?, currentParticipate: Int?, description: String?, benefit: String?, sumMonth: [SumMonth]?) {
        self.date = date
        self.name = name
        self.maxParticipate = maxParticipate
        self.currentParticipate = currentParticipate
        self.description = description
        self.benefit = benefit
        self.sumMonth = sumMonth
    }
}

// MARK: - DateElement
class DateElement: Codable {
    var id: Int?
    var date: String?
    var day: String?
    var time: [Time]?

    init(id: Int?, date: String?, day: String?, time: [Time]?) {
        self.id = id
        self.date = date
        self.day = day
        self.time = time
    }
}

class DateElementSchedule: Codable {
    var id: Int?
    var date: String?
    var day: String?
    var time: Time?

    init(id: Int?, date: String?, day: String?, time: Time?) {
        self.id = id
        self.date = date
        self.day = day
        self.time = time
    }
}

// MARK: - Time
class Time: Codable {
    var id: Int?
    var time: String?
    var trainerId: Int?
    var isCancelled: Int?
    var trainer: Trainer?
    var address: String?
    var className: String?
    var date: String?

    init(id: Int?, time: String?, trainerId: Int?, trainer: Trainer?, address: String?, className: String?) {
        self.id = id
        self.time = time
        self.trainerId = trainerId
        self.trainer = trainer
        self.address = address
        self.className = className
    }
    
    init(id: Int?, time: String?, trainerId: Int?) {
        self.id = id
        self.trainerId = trainerId
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case time
        case trainerId = "trainer_id"
        case address
        case className = "class"
        case isCancelled = "is_cancelled"
    }
}

// MARK: - Time
class SumMonth: Codable {
    var id: Int?
    var sumMonth: String?

    init(id: Int?, sumMonth: String?) {
        self.id = id
        self.sumMonth = sumMonth
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case sumMonth = "sum_month"
    }
}
