//
//  SettingsListViewComponent.swift
//  Safeye
//
//  Created by Safeye Team on 1.4.2022.
//

import SwiftUI

struct SettingsListViewComponent: View {
    let settingsView: Bool
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack {
                ForEach(0..<7) {_ in
                    SettingsListItemComponent(settingsItem: settingsView)
                }.padding(5)
            }
        }.padding(15)
    }
}

struct SettingsListViewComponent_Previews: PreviewProvider {
    static var previews: some View {
        SettingsListViewComponent(settingsView: true)
    }
}

