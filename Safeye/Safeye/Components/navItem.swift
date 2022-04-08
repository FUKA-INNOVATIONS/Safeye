//
//  navItem.swift
//  Safeye
//
//  Created by Ali Fahad on 7.4.2022.
//

import SwiftUI

struct navItem: View {
    // @Binding var action: Any
    let label: String
    let action: () -> Void
    
    // This is the parent
    // Bind it here

        var body: some View {
            TabView {
                SettingsView()
                    .tabItem(){
                        Image(systemName: "slider.3")
                        Text("Setting")
                    }
                ProfileView()
                    .tabItem(){
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
                MapView()
                    .tabItem(){
                        Image(systemName: "map.fill")
                        Text("Map")
                    }
            }
            
        }
}
