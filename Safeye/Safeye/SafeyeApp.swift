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
    @StateObject var AuthVM = AuthenticationViewModel.instance
    @StateObject var ProfileVM = ProfileViewModel.instance
    @StateObject var ConnectionVM = ConnectionViewModel.instance
    @StateObject var EventVM = EventViewModel.instance
    @StateObject var Add_ContactVM = AddContactViewModel.instance
    @StateObject var MapVM = MapViewModel()
    
    init() {
        FirebaseApp.configure() // Initialize Firebase
        
    }
    
    var body: some Scene {
        return WindowGroup {
            
            NavigationView {
                
                VStack {
                    
                    if AuthVM.isSignedIn {
                        ContentView()

                    } else {
                        LoginView()
                           // .environmentObject(AuthVM)
                    }
                    
                }
                .onAppear {
                    AuthVM.signedIn = AuthVM.isSignedIn
                }
                
            }
            .environmentObject(AuthVM)
            .environmentObject(ProfileVM)
            .environmentObject(ConnectionVM)
            .environmentObject(EventVM)
            .environmentObject(Add_ContactVM)
            .environmentObject(MapVM)
            
        }
    }
}
