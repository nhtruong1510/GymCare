//
//  TargetModel.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 03/04/2023.
//

import Foundation

// MARK: - DataClass
class TargetModel: Codable {
    var target: Target?

    init(target: Target?) {
        self.target = target
    }
}

// MARK: - Target
class Target: Codable {
    var id, walkNumber, sleep, distance: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case walkNumber = "walk_number"
        case sleep, distance
    }

    init(id: Int?, walkNumber: Int?, sleep: Int?, distance: Int?) {
        self.id = id
        self.walkNumber = walkNumber
        self.sleep = sleep
        self.distance = distance
    }
}

// MARK: - Target
class TargetHealth: Codable {
    var id, step, excercise, heartRate, customer_id: Int?
    var sleep, distance: Double?
    var date: String?

    enum CodingKeys: String, CodingKey {
        case id
        case step = "walk_number"
        case sleep, distance
        case heartRate = "heart_rate"
        case date
        case customer_id
    }
}


// MARK: - Target
class TargetList {
    var activity: [(step: Double, date: String)] = []
    var sleep: [(sleep: Double, date: String)] = []
    var walkNumber: [(step: Double, date: String)] = []
    var heartRate: [Double] = []
    var distance: [(step: Double, date: String)] = []

    var date: String = ""

    init() {}
    
    init(date: String, walkNumber: [(step: Double, date: String)],
         sleep: [(sleep: Double, date: String)],
         activity: [(step: Double, date: String)]) {
        self.date = date
        self.walkNumber = walkNumber
        self.sleep = sleep
        self.activity = activity
    }
}
