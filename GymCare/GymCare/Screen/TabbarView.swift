//
//  TabbarView.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 17/02/2023.
//

import SwiftUI

struct TabbarView: View {
    @StateObject var baseData = BaseViewModel()

    var body: some View {
        NavigationView {
            TabView {
                HomeVCRepresentation()    // 1
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                    .ignoresSafeArea()
                ScheduleVCRepresentation()
                    .tabItem {
                        Image(systemName: "calendar")
                        Text("Lịch tập")
                    }
                    .ignoresSafeArea()
                MessageAndInfoVCRepresentation()
                    .tabItem {
                        Image(systemName: "ellipsis.message")
                        Text("Chat")
                    }
                    .ignoresSafeArea()
                HealthVC1Representation()
                    .tabItem {
                        Image(systemName: "heart.fill")
                        Text("Sức khoẻ")
                    }
                    .ignoresSafeArea()
                OtherVCRepresentation()
                    .tabItem {
                        Image(systemName: "ellipsis")
                        Text("Thêm")
                    }
                    .ignoresSafeArea()
            }
        }
        .accentColor(.main_color)
        .toolbar(.hidden, for: .navigationBar)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("", displayMode: .inline)
    //    @ViewBuilder
    //    func TabButton(Tab: Tab)-> some View {
    //        Button {
    //            withAnimation{
    //                baseData.currentTab = Tab
    //            }
    //        } label: {
    //            Image(Tab.rawValue)
    //                .resizable()
    //                .renderingMode(.template)
    //                .aspectRatio(contentMode: .fit)
    //                .frame(width: 25, height: 25)
    //                .foregroundColor(baseData.currentTab == Tab ? Color("Btnbg") : Color.gray.opacity(0.5))
    //                .frame(maxWidth: .infinity)
    //        }
    //    }
        }
        
}

struct TabbarView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarView()
    }
}
