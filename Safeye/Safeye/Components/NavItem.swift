//
//  navItem.swift
//  Safeye
//
//  Created by Ali Fahad on 7.4.2022.
//

import SwiftUI

struct NavItem: View {
    init() { //UITabBar.appearance().backgroundColor = UIColor.white
        
    }
    var body: some View {
        TabView {
            
            EventListView()
                .tabItem(){
                    Image(systemName: "house")
                    Text("Home")
                }
            
            ProfileView()
                .tabItem(){
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
            
            ConnectionsView()
                .tabItem(){
                    Image(systemName: "person.3.sequence.fill")
                    Text("Connections")
                }
            
            SettingsView()
                .tabItem(){
                    Image(systemName: "slider.horizontal.3")
                    Text("Setting")
                }
            
        }

    }
}
