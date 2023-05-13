//
//  ScheduleParamObject.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 10/03/2023.
//

import Foundation

class ScheduleParamObject: Codable {
    var customer_id: Int?
    var address_id: Int?
    var class_id: Int?
    var trainer_id: Int?
    var day: String?
    var start_date: String?
    var end_date: String?
    var time: String?
    var time_id: Int?
    var date_id: Int?
    var money: Int?
    var method: Int?
    var schedule_id: Int?
    var is_create: Int?
    var status: Int?
    
    init() {}

    init(customer_id: Int?, address_id: Int?, class_id: Int?, trainer_id: Int?,
         day: String?, start_date: String?, end_date: String?,
         time: String?, date_id: Int?, time_id: Int?, money: Int? = nil, method: Int? = nil, schedule_id: Int? = nil,
         is_create: Int? = nil, status: Int? = nil) {
        self.customer_id = customer_id
        self.address_id = address_id
        self.class_id = class_id
        self.trainer_id = trainer_id
        self.day = day
        self.start_date = start_date
        self.end_date = end_date
        self.time = time
        self.time_id = time_id
        self.date_id = date_id
        self.money = money
        self.method = method
        self.schedule_id = schedule_id
        self.is_create = is_create
        self.status = status
    }
    
    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        dictionary.updateValue(castToString(self.customer_id), forKey: "customer_id")
        dictionary.updateValue(castToString(self.address_id), forKey: "address_id")
        dictionary.updateValue(castToString(self.class_id), forKey: "class_id")
        dictionary.updateValue(castToString(self.trainer_id), forKey: "trainer_id")
        dictionary.updateValue(castToString(self.day), forKey: "day")
        dictionary.updateValue(castToString(self.start_date), forKey: "start_date")
        dictionary.updateValue(castToString(self.end_date), forKey: "end_date")
        dictionary.updateValue(castToString(self.time), forKey: "time")
        dictionary.updateValue(castToString(self.time_id), forKey: "time_id")
        dictionary.updateValue(castToString(self.date_id), forKey: "date_id")
        dictionary.updateValue(castToString(self.money), forKey: "money")
        dictionary.updateValue(castToString(self.method), forKey: "method")
        dictionary.updateValue(castToString(schedule_id), forKey: "schedule_id")

        if let is_create = is_create {
            dictionary.updateValue(is_create, forKey: "is_create")
        }
        if let status = status {
            dictionary.updateValue(castToString(status), forKey: "status")
        }
        return dictionary
    }
}
