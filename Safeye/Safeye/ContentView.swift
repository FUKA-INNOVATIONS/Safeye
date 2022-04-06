//
//  ContentView.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var inputText: String = "Hello input"
    @State var passsword: String = ""
    @EnvironmentObject var AuthenticationViewModel: AuthenticationViewModel
    
    var body: some View {
        Section {
            VStack {
                if AuthenticationViewModel.isSignedIn {
                    // User is signed in
                    BasicButtonComponent(label: "Sign out") { // Sign out button
                        AuthenticationViewModel.signOut()
                    }
                } else {
                    // User has not signed in
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
