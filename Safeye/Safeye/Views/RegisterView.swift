//
//  RegisterView.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//

import SwiftUI

struct RegisterView: View {
    @State var email = ""
    @State var password = ""
    @ObservedObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        VStack {
            InputFieldComponent(title: "Email address", inputText: $email)
            SecureInputFieldComponent(title: "Password", secureText: $password)
            
            BasicButtonComponent(label: "Create account") {
                // Email and password not provided
                guard !email.isEmpty, !password.isEmpty else {
                    return
                }
                
                // Email and password is provided, create new account
                viewModel.signUp(email: email, password: password)
                print("Register")
            }
            
        }
        .padding()
        .navigationTitle("Create new account")
    }
}

