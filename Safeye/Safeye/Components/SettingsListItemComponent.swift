//
//  SettingsListItemComponent.swift
//  Safeye
//
//  Created by gintare on 8.4.2022.
//

import SwiftUI

struct SettingsListItemComponent: View {
    // if true, displays settings item
    // if false, it shows contact details for curtain view
    let settingsItem: Bool
    
    var body: some View {
        HStack {
            if settingsItem {
                Image("icon-add").padding()
            } else {
                AvatarComponent(size: 40).padding()
            }
            VStack(alignment: .leading){
                settingsItem ?
                Text("Headline")
                    .font(.system(size: 25, weight: .bold))
                : Text("FirstName LastName")
                
                settingsItem ? Text("TLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ") : Text("Maybe home address?")
            }
            Spacer()
            //icon size isn't adjusting, not sure why
            //when we figure out what items to use, I think a separate modifier should be created
            settingsItem ? Image("icon-play") : Image("icon-pinpoint")
            
        }.padding()
            .frame(
                minWidth: 100,
                maxWidth: .infinity,
                maxHeight: settingsItem ? 150 : 90,
                alignment: .leading
            )
            .background(.gray)
    }
}

struct SettingsListItemComponent_Previews: PreviewProvider {
    static var previews: some View {
        SettingsListItemComponent(settingsItem: true)
    }
}
