//
//  SettingsView.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//

import SwiftUI

struct SettingsView: View {
        var body: some View {
            ZStack {
                Color.green
                
                Image(systemName: "slider.horizontal.3")
                    .foregroundColor(Color.white)
                    .font(.system(size: 100.0))
            }
            NavItem()
            
        }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
