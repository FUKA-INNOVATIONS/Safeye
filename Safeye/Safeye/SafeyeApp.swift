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
    @StateObject private var appStore = Store.shared
    @StateObject private var Safeyecontroller = SafeyeController()
    
    @StateObject private var AuthVM = AuthenticationViewModel.shared
    @StateObject private var ProfileVM = ProfileViewModel.shared
    @StateObject private var ConnectionVM = ConnectionViewModel.shared
    @StateObject private var EventVM = EventViewModel.shared
    @StateObject private var MapVM = MapViewModel()
    @StateObject private var FileVM = FileViewModel.shared
    @StateObject private var CityVM = CityViewModel.shared
    
    @StateObject private var PlaygroundVM = PlaygroundViewModel.shared
    

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
            .environmentObject(CityVM)
            .environment(\.managedObjectContext, Safeyecontroller.container.viewContext)
        }
    }
}
