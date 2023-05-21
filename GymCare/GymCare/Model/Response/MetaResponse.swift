//
//  MetaResponse.swift
//
//  Created by Truong Nguyen Huu on 04/10/2022.
//

import Foundation

class MetaResponse: Codable {

    var currentPage: Int?
    var totalPage: Int?
    var read: Int?
    var count: Int?

    init() { }

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case totalPage = "total_page"
        case read
        case count
    }

    required init(from decoder: Decoder) throws {
        let personContainer = try decoder.container(keyedBy: CodingKeys.self)
        currentPage = try personContainer.decodeIfPresent(Int.self, forKey: .currentPage)
        totalPage = try personContainer.decodeIfPresent(Int.self, forKey: .totalPage)
        read = try personContainer.decodeIfPresent(Int.self, forKey: .read)
        count = try personContainer.decodeIfPresent(Int.self, forKey: .count)
    }

}
