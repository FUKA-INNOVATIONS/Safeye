//
//  SafeyeApp.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//

import SwiftUI
import Firebase // Import Firebase

@main
struct SafeyeApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var AuthVM = AuthenticationViewModel()
    @StateObject var ProfileVM = ProfileViewModel()
    
    init() {
        FirebaseApp.configure() // Initialize Firebase
        
    }
    
    var body: some Scene {
        return WindowGroup {
            NavigationView {
                VStack {
                    ContentView()
                        .environmentObject(AuthVM)
                        .environmentObject(ProfileVM)
                    
                    
                    if AuthVM.isSignedIn {
                        NavItem()
                            .environmentObject(ProfileVM)
                            .environmentObject(AuthVM)
                    }
                    
                }
                .onAppear {
                    AuthVM.signedIn = AuthVM.isSignedIn
                }
            }
            
        }
    }
}
