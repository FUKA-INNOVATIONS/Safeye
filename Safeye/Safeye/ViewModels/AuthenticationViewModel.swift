//
//  AuthenticationViewModel.swift
//  Safeye
//
//  Created by FUKA on 6.4.2022.
//


/*
 TODO: Class Explanation
 */

import FirebaseAuth // Import Firebase Authentication

class AuthenticationViewModel: ObservableObject {
    let auth = Auth.auth()
    
    @Published var signedIn = false
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String) { // Login user with email and password
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            // Login Success
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    
    func signUp(email: String, password: String) { // Create new user account with email and password
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
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
        try? auth.signOut()
        self.signedIn = false
    }
    
}
