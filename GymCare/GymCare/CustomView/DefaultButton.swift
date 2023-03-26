//
//  DefaultButton.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 14/02/2023.
//

import Foundation
import SwiftUI

struct DefaultButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.main_color)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .font(.system(size: 16, weight: Font.Weight.bold))
            .frame(width: 300)
    }
}
