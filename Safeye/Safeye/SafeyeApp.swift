//
//  SafeyeApp.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//

import SwiftUI

@main
struct SafeyeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
