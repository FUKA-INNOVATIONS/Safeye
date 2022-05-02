//
//  NavItem.swift
//  Safeye
//
//  Created by Safeye Team on 1.4.2022.
//

import SwiftUI

struct NavItem: View {
    init() { //UITabBar.appearance().backgroundColor = UIColor.white
        
    }
    var translationManager = TranslationService.shared
    
    var body: some View {
        TabView {
            
            EventListView()
                .tabItem(){
                    Image(systemName: "house")
                    Text(translationManager.homeNav)
                }
            
            ProfileView()
                .tabItem(){
                    Image(systemName: "person.fill")
                    Text(translationManager.profileNav)
                }
            
            ConnectionsView()
                .tabItem(){
                    Image(systemName: "person.3.sequence.fill")
                    Text(translationManager.connectNav)
                }
            
            SettingsView()
                .tabItem(){
                    Image(systemName: "slider.horizontal.3")
                    Text(translationManager.settingsNav)
                }
        }
    }
}
