//
//  RegisterView.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 16/02/2023.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .frame(width: 25, height: 20)
                    }
                        .foregroundColor(.main_color)
                    Spacer()

                }
                VStack {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .padding(50)
                }
                VStack {
                    TextField("Nhập email hoặc số điện thoại", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                        .textFieldStyle(CustomTextField(systemImageString: "envelope.fill"))
                        .padding(.bottom)
                    TextField("Nhập tên đăng nhập", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                        .textFieldStyle(CustomTextField(systemImageString: "person.fill"))
                        .padding(.bottom)
                    SecureField("Nhập mật khẩu", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                        .textFieldStyle(CustomTextField(systemImageString: "lock.fill"))
                        .padding(.bottom)
                    SecureField("Xác nhận mật khẩu", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                        .textFieldStyle(CustomTextField(systemImageString: "lock.fill"))
                        .padding(.bottom)
                }
                .padding(.bottom)
                HStack {
                    Button("Đăng ký") {
                        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                    }.buttonStyle(DefaultButton())
                }
                .background(Color.main_color)
                .clipShape(Capsule())
            }
            .padding()
            .toolbar(.hidden, for: .navigationBar)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("", displayMode: .inline)
            .padding(.bottom, 100)
        }
        .toolbar(.hidden, for: .navigationBar)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("", displayMode: .inline)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
