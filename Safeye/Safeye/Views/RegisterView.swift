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
    
    @StateObject private var translationManager = TranslationService()
    
    var body: some View {
        VStack {
            InputFieldComponent(title: translationManager.createEmailTitle, inputText: $email)
            SecureInputFieldComponent(title: translationManager.createPasswordTitle, secureText: $password)
            
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
        .navigationTitle(translationManager.createNewAcc)
    }
}

