//
//  BaseViewModel.swift
//  Uray
//
//  Created by Shameem Reza on 11/3/22.
//

import SwiftUI

class BaseViewModel: ObservableObject {
    
    let repository = ApiRepository()

    // MARK: - TAB BAR
    @Published var currentTab: Tab = .Home
    
    @Published var homeTab = "Facewash"
    
    // MARK: - DETAIL VIEW
    @Published var showDetail = false
}

// MARK: - TAB ITEM CASE
enum Tab: String {
    case Home = "home"
    case Heart = "heart"
    case ClipBoard = "clipboard"
    case Person = "person"
}
