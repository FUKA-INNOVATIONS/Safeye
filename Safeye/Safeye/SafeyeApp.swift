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
    
    init() {
        FirebaseApp.configure() // Initialize Firebase
    }

    var body: some Scene {
        WindowGroup {
            //let AuthenticationViewModel = // AuthenticationViewModel()
            NavigationView {
                MapView()
                //ContentView()
                  //  .environment(\.managedObjectContext, persistenceController.container.viewContext)
                  //  .environmentObject(AuthenticationViewModel)
            }
        }
    }
}
