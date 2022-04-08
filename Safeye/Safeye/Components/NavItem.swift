//
//  navItem.swift
//  Safeye
//
//  Created by Ali Fahad on 7.4.2022.
//

import SwiftUI

struct NavItem: View {

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
