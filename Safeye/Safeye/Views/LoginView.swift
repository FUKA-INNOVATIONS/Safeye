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
    var translationManager = TranslationService.shared
    
    var body: some View {
        VStack{
            //            InputFieldComponent(title: "Email address", inputText: $email)
            //            SecureInputFieldComponent(title: "Password", secureText: $password)
            //            InputFieldComponent(title: translationManager.createEmailTitle, inputText: $email)
            
            LoginInputComponent(title: translationManager.emailTitle, inputText: $email, icon: "envelope")
            SecureInputFieldComponent(title: translationManager.passwordTitle, secureText: $password)
            
            //            BasicButtonComponent(label: "Sign In", action: {
            BasicButtonComponent(label: translationManager.signInButton, action: {
                // Email and password not provided
                guard !email.isEmpty, !password.isEmpty else {
                    return
                }
                // Email and password is provided, try to sign the user in
                viewModel.signIn(email: email, password: password)
            })
            
            // Go to Register view
            //            NavigationLink("Create a new account", destination: RegisterView(viewModel: viewModel))
            NavigationLink(translationManager.createNewAcc, destination: RegisterView(viewModel: viewModel))
                .foregroundColor(Color.blue)
                .padding()
        }
        Spacer()
        // Show alert on login failure
        //        .alert("Login failed", isPresented: $viewModel.signinError) {
        //            Button("OK", role: .cancel) { }
        .alert(translationManager.loginAlertTitle, isPresented: $viewModel.signinError) {
            Button(translationManager.okBtn, role: .cancel) { }
        }
        //        .navigationTitle("Sign in") // TODO: this creates warnings
        .navigationTitle(translationManager.signInTitle) // TODO: this creates warnings
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
