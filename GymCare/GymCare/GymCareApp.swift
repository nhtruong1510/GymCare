//
//  GymCareApp.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 12/02/2023.
//

import SwiftUI

@main
struct GymCareApp: App {
    var body: some Scene {
        WindowGroup {
            if ServiceSettings.shared.userInfo != nil {
                TabbarView()
                    .environment(\.colorScheme, .light)
            } else {
                ContentView()
                    .environment(\.colorScheme, .light)
            }
            
        }
    }
}
