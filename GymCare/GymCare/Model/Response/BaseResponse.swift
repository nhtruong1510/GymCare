//
//  BaseResponse.swift
//  SchoolUp
//
//  Created by Nguyen Ha on 07/02/2023.
//

import Foundation

class BaseResponse: Codable {
    
    var id: Int?

    enum CodingKeys: String, CodingKey {
        case id
    }

}


