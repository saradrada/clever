//
//  LoginView.swift
//  StudyBuddy
//
//  Created by Sara Ortiz Drada on 16.07.23.
//

import SwiftUI

struct LoginView: View {
//    @ObservedObject var loginViewModel: LoginViewModel = LoginViewModel()
    @State var showingPassword: Bool = false
    @Binding var password: String
    @Binding var username: String

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.white, .blue]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 17) {
                Text("Welcome")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom)
                Image("read")
                    .padding(.bottom,50)
                TextField("Username", text: $username)
                    .frame(height: 22)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .customTextField()
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("Purple Text"), lineWidth: 0.6))
                HStack {
                    if showingPassword {
                        TextField("Password", text: $password)
                            .frame(height: 22)
                            .customTextField()
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("Purple Text"), lineWidth: 0.6))
                        Image(systemName: "eye.slash")
                            .onTapGesture {
                                showingPassword.toggle()
                            }
                    } else {
                        SecureField("Password", text: $password)
                            .frame(height: 22)
                            .customTextField()
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("Purple Text"), lineWidth: 0.6))
                        Image(systemName: "eye")
                            .onTapGesture {
                                showingPassword.toggle()
                            }
                            .foregroundColor(Color("Purple Text"))
                    }
                }
                WideButton(text: "Log In") {
//                    loginViewModel.login()
                }
            }
            .padding(.horizontal)
        }
        
    }
}

#Preview {
    @State var password = ""
    @State var username = ""

    return LoginView(showingPassword: false, password: $password, username: $username)
}

