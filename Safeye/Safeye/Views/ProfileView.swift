//
//  ProfileView.swift
//  Safeye
//
//  Created by gintare on 7.4.2022.
//  Edited by FUKA on 8.4.2022.

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var ProfileVM: ProfileViewModel
    
    @State private var showingEditProfile = false
    @State private var showModal = false
    
    var body: some View {
        VStack {
            Group{
                Spacer()
                Text("\(ProfileVM.profileDetails?.fullName ?? "No name")")
                    .font(.system(size: 25, weight: .bold))
                
                // Show edit profile view in a Modal
                BasicButtonComponent(label: "Edit profile details") {
                    showingEditProfile = true
                }
                .sheet(isPresented: $showingEditProfile) {
                    ProfileEditView()
                }
                
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
            
        }
      AddContactView(isShowing: $showModal)
        .onAppear {
            ProfileVM.getProfile()
        }
            

        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
