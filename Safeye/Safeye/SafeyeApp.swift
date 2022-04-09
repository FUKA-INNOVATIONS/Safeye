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
                ContentView()
                // .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(AuthVM)
                    .environmentObject(ProfileVM)
            }
            
        }
    }
}
