//
//  SafeyeApp.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//

import SwiftUI
import Firebase

@main
struct SafeyeApp: App {
    @StateObject var appStore = Store.shared
    
    @StateObject var AuthVM = AuthenticationViewModel.shared
    @StateObject var ProfileVM = ProfileViewModel.shared
    @StateObject var ConnectionVM = ConnectionViewModel.shared
    @StateObject var EventVM = EventViewModel.shared
    @StateObject var MapVM = MapViewModel()
    @StateObject var FileVM = FileViewModel.shared
    
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
            .environmentObject(MapVM)
            .environmentObject(appStore)
            .environmentObject(PlaygroundVM)
            .environmentObject(FileVM)
        }
    }
}
