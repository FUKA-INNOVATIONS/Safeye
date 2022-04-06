//
//  ContentView.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//

import SwiftUI

struct ContentView: View {
    
    // var showEmailField = InputFieldComponent(title: "Email address", text: "")
    @State var inputText: String = "Hello input"
    @State var passsword: String = ""
    @EnvironmentObject var AuthenticationViewModel: AuthenticationViewModel
    
    let sayHello = { print("Hello") }
    
    
    var body: some View {
        Section {
            VStack {
                // InputFieldComponent(title: "Email address", inputText: $inputText)
                // SecureInputFieldComponent(title: "Password", secureText: $passsword)
                // BasicButtonComponent(label: "Tap tap", action: sayHello)
                
                if AuthenticationViewModel.isSignedIn {
                    // User is signed in
                    BasicButtonComponent(label: "Sign out") {
                        AuthenticationViewModel.signOut()
                    }
                } else {
                    LoginView() // Show Login
                }
                
            }
        }
        .onAppear {
            AuthenticationViewModel.signedIn = AuthenticationViewModel.isSignedIn
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
