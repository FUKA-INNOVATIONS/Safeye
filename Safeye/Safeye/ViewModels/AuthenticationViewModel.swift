//
//  AuthenticationViewModel.swift
//  Safeye
//
//  Created by Safeye Team on 1.4.2022.

//


/*
 TODO: Class Explanation
 */

import SwiftUI

class AuthenticationViewModel: ObservableObject {
    static let shared = AuthenticationViewModel() ;  private init() {}
    let authService = AuthenticationService.getInstance
    var appState = Store.shared
    
    @Published var signedIn = false
    @Published var signinError = false
    
    var isSignedIn: Bool {
        return authService.currentUser != nil
    }
    
    
    // Get and return current logged in user, if user is not logged in return nil
    func getCurrentUser() -> UserModel? {
        // Google recommended way of getting current user
        if authService.currentUser != nil { // User is signed in, get id and email TODO: refacor code
            let userId = authService.currentUser?.uid
            let userEmail = authService.currentUser?.email
            return UserModel(id: userId, email: userEmail!)
        } else {
            // No user is signed in.
            return nil
        }
        
    } // end of getCurrentUser()
    
    
    
    func signIn(email: String, password: String) { // Login user with email and password
        self.appState.appLoading = true
        authService.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                self?.signinError = true
                self?.appState.appLoading = false
                return
            }
            // Login Success
            DispatchQueue.main.async {
                self?.signinError = false
                self?.signedIn = true
                self?.appState.currentUserID = result!.user.uid
                self?.appState.currentUserEmail = result!.user.email!
                self?.appState.appLoading = false
            }
        }
    }
    
    func signUp(email: String, password: String) { // Create new user account with email and password
        self.appState.appLoading = true
        authService.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                self?.appState.appLoading = false
                return
            }
            // Account creation Success
            DispatchQueue.main.async {
                self?.signedIn = true
                self?.appState.appLoading = false
                self?.appState.currentUserID = result!.user.uid
                
            }
        }
    }
    
    func signOut() { // Logout user
        self.appState.appLoading = true
        try? authService.signOut()
        self.signedIn = false
        self.appState.currentUserID = ""
        self.appState.currentUserEmail = ""
        self.appState.appLoading = false
    }
    
}
