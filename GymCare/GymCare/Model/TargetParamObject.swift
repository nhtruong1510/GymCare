//
//  TargetParamObject.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 03/04/2023.
//

import Foundation

class TargetParamObject: Codable {
    var customer_id: Int?
    var distance: Int?
    var walk_number: Int?
    var sleep: Int?
    var sleepHealth: Double?
    var distanceHealth: Double?
    var heartRate: Int?
    var excercise: Int?
    var date: String?

    init() {}

    init(customer_id: Int?, distance: Int?, walk_number: Int?, sleep: Int?) {
        self.customer_id = customer_id
        self.distance = distance
        self.walk_number = walk_number
        self.sleep = sleep
    }
    
    init(distanceHealth: Double?, walk_number: Int?, sleepHealth: Double?,
         heartRate: Int?, excercise: Int?, date: String?) {
        self.distanceHealth = distanceHealth
        self.walk_number = walk_number
        self.sleepHealth = sleepHealth
        self.heartRate = heartRate
        self.excercise = excercise
        self.date = date
    }
    
    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        dictionary.updateValue(castToString(self.customer_id), forKey: "customer_id")
        dictionary.updateValue(castToString(self.distance), forKey: "distance")
        dictionary.updateValue(castToString(self.walk_number), forKey: "walk_number")
        dictionary.updateValue(castToString(self.sleep), forKey: "sleep")
        return dictionary
    }
    
    func toDictionaryHealth() -> [String: Any] {
        var dictionary = [String: Any]()
        dictionary.updateValue(castToString(ServiceSettings.shared.userInfo?.id), forKey: "customer_id")
        dictionary.updateValue(castToString(self.distanceHealth), forKey: "distance")
        dictionary.updateValue(castToString(self.walk_number), forKey: "walk_number")
        dictionary.updateValue(castToString(self.sleepHealth), forKey: "sleep")
        dictionary.updateValue(castToString(self.heartRate), forKey: "heart_rate")
        dictionary.updateValue(castToString(self.excercise), forKey: "excercise")
        dictionary.updateValue(castToString(self.date), forKey: "date")
        return dictionary
    }
}
