//
//  navItem.swift
//  Safeye
//
//  Created by Ali Fahad on 7.4.2022.
//

import SwiftUI

struct NavItem: View {
    init() {
        
        UITabBar.appearance().backgroundColor = UIColor.gray
        
    }
    var body: some View {
        TabView {
            
            SettingsView()
                .tabItem(){
                    Image(systemName: "slider.horizontal.3")
                    Text("Setting")
                }
            
            MapView()
                .tabItem(){
                    Image(systemName: "map.fill")
                    Text("Map")
                }
            
            ProfileView()
                .tabItem(){
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
    }
}
