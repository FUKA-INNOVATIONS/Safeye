//
//  ProfileView.swift
//  Safeye
//
//  Created by gintare on 7.4.2022.
//  Edited by FUKA on 8.4.2022.

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var ProfileVM: ProfileViewModel
    @EnvironmentObject var ConnectionVM: ConnectionViewModel
    @EnvironmentObject var appState: Store
    
    @State private var showingEditProfile = false
    @State private var showingAddContact = false
    @State private var showingAddSafePlace = false
    @State private var showingCreateEvent = false


    var body: some View {
        
        ZStack {
            VStack {

                Group{
                    AvatarComponent(size: 80)
                    Spacer()

                    HStack {
                        Text("\(appState.profile?.fullName ?? "No name")")
                            .font(.system(size: 25, weight: .bold))
                        
                        Button { showingEditProfile = true } label: { Image(systemName: "pencil.circle.fill") }
                    }
                    .sheet(isPresented: $showingEditProfile) {
                        ProfileEditView()
                    }
    
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
                
                VStack {
                    Button("Create new event", action: { showingCreateEvent = true } )
                    .sheet(isPresented: $showingCreateEvent) {
                        CreateEventView()
                    }
                    UserDetailsComponent()
                }
                
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
            }
            AddContactView(isShowing: $showingAddContact, searchInput: "")
            AddSafePlaceView(isShowing: $showingAddSafePlace)
        }
        .onAppear {
            ConnectionVM.getConnections()
            ConnectionVM.getConnectionProfiles()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
