//
//  LoginView.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//

/*
 TODO: Class Explanation
 */

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    var body: some View {
        
        VStack {
            InputFieldComponent(title: "Email address", inputText: $email)
            SecureInputFieldComponent(title: "Password", secureText: $password)
            
            BasicButtonComponent(label: "Sign In", action: {
                // Email and password not provided
                guard !email.isEmpty, !password.isEmpty else {
                    return
                }
                // Email and password is provided, try to sign the user in
                viewModel.signIn(email: email, password: password)
            })
            
            // Go to Register view
            NavigationLink("Create a new account", destination: RegisterView(viewModel: viewModel))
                .padding()
        }
        // Show alert on login failure
        .alert("Login failed", isPresented: $viewModel.signinError) {
            Button("OK", role: .cancel) { }
        }
        .navigationTitle("Sign in") // TODO: this creates warnings
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
