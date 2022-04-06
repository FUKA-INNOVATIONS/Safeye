//
//  AuthenticationViewModel.swift
//  Safeye
//
//  Created by FUKA on 6.4.2022.
//


/*
 TODO: Class Explanation
 */

import SwiftUI

class AuthenticationViewModel: ObservableObject {
    let authService = AuthenticationService.getInstance
    
    @Published var signedIn = false
    @Published var signinError = false
    
    var isSignedIn: Bool {
        return authService.currentUser != nil
    }
    
    func signIn(email: String, password: String) { // Login user with email and password
        authService.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                self?.signinError = true
                // print("Error in signIn() -> viewModel: \(error?.localizedDescription)")
                return
            }
            // Login Success
            DispatchQueue.main.async {
                self?.signinError = false
                self?.signedIn = true
            }
        }
    }
    
    func signUp(email: String, password: String) { // Create new user account with email and password
        authService.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            // Account creation Success
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    
    func signOut() { // Logout user
        try? authService.signOut()
        self.signedIn = false
    }
    
}
