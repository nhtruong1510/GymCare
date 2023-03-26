//
//  BannerResponse.swift
//  SchoolUp
//
//  Created by Nguyen Ha on 07/02/2023.
//

import Foundation

class BannerModel: Codable {
    
    var id: Int?
    var title: String?
    var description: String?
    var background: String?
    var sourceUrl: String?
    var link: String?
    var type: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case background
        case sourceUrl = "source_url"
        case link
        case type
    }

}
