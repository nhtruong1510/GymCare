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
    
    init() {}

    init(customer_id: Int?, distance: Int?, walk_number: Int?, sleep: Int?) {
        self.customer_id = customer_id
        self.distance = distance
        self.walk_number = walk_number
        self.sleep = sleep
    }
    
    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        dictionary.updateValue(castToString(self.customer_id), forKey: "customer_id")
        dictionary.updateValue(castToString(self.distance), forKey: "distance")
        dictionary.updateValue(castToString(self.walk_number), forKey: "walk_number")
        dictionary.updateValue(castToString(self.sleep), forKey: "sleep")
        return dictionary
    }
}
