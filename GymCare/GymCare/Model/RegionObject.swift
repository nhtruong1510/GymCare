//
//  RegionObject.swift
//  AppPit
//
//  Created by Truong Nguyen Huu on 18/08/2022.
//

import Foundation

class RegionObject: Codable {

    var _id: Int?
    var code: String?
    var name: String?
    var avatar: String?
    var unit: String?
    var tax: Double?
    var taxPrice: Int?
    var districtCode: String?
    var distance: Double?

    init() {}
    
    init(id: Int?, code: String? = nil, name: String?, avatar: String? = nil, distance: Double? = nil) {
        self._id = id
        self.code = code
        self.name = name
        self.avatar = avatar
        self.distance = distance

    }

    private enum CodingKeys: String, CodingKey {
        case _id
        case code
        case name
        case unit
        case tax = "tax"
        case taxPrice = "tax_price"
        case districtCode = "district_code"
        case distance
    }
}
