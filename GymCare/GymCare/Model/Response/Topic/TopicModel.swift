//
//  TopicModel.swift
//  SchoolUpTeacher
//
//  Created by Nguyen Ha on 10/01/2023.
//

import Foundation

class TopicModel: Codable {
    
    var currentPage: Int?
    var total: Int?
    var datas: [TopicDetailModel] = []

    private enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case total
        case datas = "data"
    }

}
