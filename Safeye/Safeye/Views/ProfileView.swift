//
//  ProfileView.swift
//  Safeye
//
//  Created by gintare on 7.4.2022.
//  Edited by FUKA on 8.4.2022.

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var ProfileVM: ProfileViewModel
    @EnvironmentObject var appState: Store
    
    @State private var showingEditProfile = false
    @State private var showingAddContact = false

    @ObservedObject var EventVM = EventViewModel.shared
    
    @State private var showingAddSafePlace = false


    var body: some View {
        
        ZStack {
            VStack {
                NavigationLink {
                    CreateEventView()
                } label: {
                    Text("Create event")
                }

                Group{

                    Spacer()
                    NavigationLink("Tracking (TEMP)", destination: EventView())

                    Text("\(appState.profile?.fullName ?? "No name")")
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
                    HStack{
                        ListViewComponent(item: "avatar", size: 50)
                        Button(action: {
                            showingAddContact = true
                        })
                        { Image("icon-add") }
                        Spacer(minLength: 20)
                    }
                    Spacer()
                }
                UserDetailsComponent()
                Spacer()
                Group {
                    Text("My safe spaces").font(.system(size: 18, weight: .semibold))
                    HStack{
                    //size with icons doesn't work properly, will figure this out later
                    ListViewComponent(item: "safeSpace", size: 40)
                        Button(action: {
                            showingAddSafePlace = true
                            print("modal: ($showingAddSafePlace)")
                        })
                        { Image("icon-add") }
                        Spacer(minLength: 20)
                    }
                    Spacer()
                }
                
                
            }
            .onAppear {
                ProfileVM.getProfileForCurrentUser()
                print("PPPPPPPPPPPP: \(appState.profile)")
            }

            AddContactView(isShowing: $showingAddContact, searchInput: "")
                .sheet(isPresented: $showingAddSafePlace) {
                    AddSafePlaceView()
        }
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
}
