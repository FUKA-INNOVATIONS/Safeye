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
    //let persistenceController = PersistenceController.shared
    
    @StateObject var AuthVM = AuthenticationViewModel.shared
    @StateObject var ProfileVM = ProfileViewModel.shared
    @StateObject var ConnectionVM = ConnectionViewModel.shared
    @StateObject var EventVM = EventViewModel.shared
    @StateObject var Add_ContactVM = AddContactViewModel.shared
    @StateObject var MapVM = MapViewModel()
    @StateObject var FileVM = FileViewModel.shared
    
    @StateObject var appStore = Store.shared
    @StateObject var PlaygroundVM = PlaygroundViewModel.shared
    

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
            .environmentObject(appStore)
            .environmentObject(PlaygroundVM)
            .environmentObject(FileVM)
            
        }
    }
}
