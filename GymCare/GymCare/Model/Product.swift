//
//  Health.swift
//  Uray
//
//  Created by Shameem Reza on 11/3/22.
//

import SwiftUI

class Health: Codable, Identifiable {
    var image: String
    var title: String
    var content: String
    var description: String
    var showProgress: Bool

    init(image: String, title: String, content: String, description: String, showProgress: Bool) {
        self.image = image
        self.title = title
        self.content = content
        self.description = description
        self.showProgress = showProgress
    }
}

var healths = [
    Health(image: "product1", title: "Số bước chạy", content: "0 km", description: "Attenir Skin Clear Cleanse Oil cleanses makeup, skin stains and impurities on the skin while leaving it supple and firm.", showProgress: true),
    Health(image: "product2", title: "Nhịp tim", content: "0", description: "Dress Lift Day Emulsion is Attenir's anti-ageing regenerating lifting emulsion for daily facial care.", showProgress: false),
    Health(image: "product3", title: "Số giờ ngủ", content: "0", description: "Recast vitamin c facial serum is a extremely light weight serum infused with the stable form of vitamin c.", showProgress: true),
    Health(image: "product4", title: "SpO2", content: "60.0", description: "Let the luxurious feel and exotic scents of Hawaiian Tropic Sheer Touch take you to the tropics.", showProgress: true)
]
