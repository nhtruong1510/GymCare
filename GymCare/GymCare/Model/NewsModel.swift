//
//  NewsModel.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 02/05/2023.
//

import Foundation

// MARK: - Datum
class NewsModel: Codable {
    var id: Int?
    var title: String?
    var url: String?
    var image: String?
    var role: Int?

    init(id: Int?, title: String?, url: String?, image: String?, role: Int?) {
        self.id = id
        self.title = title
        self.url = url
        self.image = image
        self.role = role
    }
}
