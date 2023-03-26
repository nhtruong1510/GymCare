//
//  AddressModel.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 09/03/2023.
//

import Foundation

class AddressModel: Codable {
    var address: [Address]?
}

class Address: Codable {
    var id: Int?
    var lattitude, longitude: Double?
    var image: String?
    var address: String?
    var addressClass: Class?
    
    enum CodingKeys: String, CodingKey {
        case id, lattitude, longitude, image
        case addressClass = "class"
        case address
    }
    
    init() {}
    init(id: Int?, lattitude: Double? = nil, longitude: Double? = nil, image: String? = nil, address: String?, addressClass: Class?) {
        self.id = id
        self.lattitude = lattitude
        self.longitude = longitude
        self.image = image
        self.address = address
        self.addressClass = addressClass
    }
}
