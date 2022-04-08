//
//  ProfileView.swift
//  Safeye
//
//  Created by gintare on 7.4.2022.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        
        VStack {
            Group{
            Spacer()
                Text("FirstName LastName").font(.system(size: 25, weight: .bold))
            AvatarComponent(size: 80)
            Spacer()
            }
            Group {
                Text("My trusted contacts").font(.system(size: 18, weight: .semibold))
                ListViewComponent(item: "avatar", size: 50)
            Spacer()
            }
            UserDetailsComponent()
            Spacer()
            Group {
                Text("My safe spaces").font(.system(size: 18, weight: .semibold))
                
                //size with icons doesn't work properly, will figure this out later
                ListViewComponent(item: "safeSpace", size: 40)
                
                Spacer()
            }
            //a button will be placed here?
        }
      NavItem()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
