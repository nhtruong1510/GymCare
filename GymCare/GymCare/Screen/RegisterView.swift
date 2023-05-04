//
//  RegisterView.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 16/02/2023.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showLoginView = false
    @State private var phone: String = ""
    @State private var password: String = ""
    @State private var name: String = ""
    @State private var confirmPassword: String = ""
    let viewModel = RegisterViewModel()

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
                    TextField("Nhập email hoặc số điện thoại", text: $phone)
                        .textFieldStyle(CustomTextField(systemImageString: "envelope.fill"))
                        .padding(.bottom)
                    TextField("Nhập tên đăng nhập", text: $name)
                        .textFieldStyle(CustomTextField(systemImageString: "person.fill"))
                        .padding(.bottom)
                    SecureField("Nhập mật khẩu", text: $password)
                        .textFieldStyle(CustomTextField(systemImageString: "lock.fill"))
                        .padding(.bottom)
                    SecureField("Xác nhận mật khẩu", text: $confirmPassword)
                        .textFieldStyle(CustomTextField(systemImageString: "lock.fill"))
                        .padding(.bottom)
                }
                .padding(.bottom)
                HStack {
                    Button("Đăng ký") {
                        viewModel.callApiRegister(email: $phone.wrappedValue, name: $name.wrappedValue,
                                                  pass: $password.wrappedValue, confirmPass: $confirmPassword.wrappedValue) { success, error in
                            if success {
                                self.showLoginView = true
                            } else {
                                self.showLoginView = false
                            }
                        }
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
