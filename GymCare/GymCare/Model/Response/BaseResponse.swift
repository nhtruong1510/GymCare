//
//  BaseResponse.swift
//  GymCare
//
//

import Foundation

class BaseResponse: Codable {
    
    var id: Int?

    enum CodingKeys: String, CodingKey {
        case id
    }

}


