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
    var translationManager = TranslationService.shared

    
    var body: some View {
        VStack {
//            InputFieldComponent(title: "Email address", inputText: $email)
//            SecureInputFieldComponent(title: "Password", secureText: $password)
//            InputFieldComponent(title: translationManager.createEmailTitle, inputText: $email)
            LoginInputComponent(title: translationManager.emailTitle, inputText: $email)
            SecureInputFieldComponent(title: translationManager.createPasswordTitle, secureText: $password)
            

//            BasicButtonComponent(label: "Create account") {
            BasicButtonComponent(label: translationManager.signUpButton) {
                // Email and password not provided
                guard !email.isEmpty, !password.isEmpty else {
                    return
                }
                
                // Email and password is provided, create new account
                viewModel.signUp(email: email, password: password)
                print("Register")
            }
            
        }
        Spacer()
//        .navigationTitle("Create new account")
        .navigationTitle(translationManager.createNewAcc)
//        .navigationBarItems(
//                    trailing: LogoComponent()
//                )
    }
}

