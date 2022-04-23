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
    @EnvironmentObject var FileVM: FileViewModel
    @EnvironmentObject var EventVM: EventViewModel
    
    @State private var showingEditProfile = false
    @State private var showingAddContact = false
    @State private var showingAddSafePlace = false
    
    @State var isImagePickerShowing = false
    @State var selectedPhoto: UIImage?
    
    var body: some View {
        
        ZStack {
            VStack {
                Group{
                    // Display profile photo
                    VStack {
                        // if user already has a profile photo, display that
                        if appState.userPhoto != nil {
                            ProfileImageComponent(size: 100, avatarImage: appState.userPhoto!)
                        } else {
                            ProgressView()
                        }
                    }
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
                
                
                
                Spacer()
                
                Group {
                    Spacer()
                    Text("My trusted contacts").font(.system(size: 18, weight: .semibold))
                    HStack{
                        ForEach(appState.connectionProfilesWithAvatars) { connection in
                            VStack {
                                ProfileImageComponent(size: 70, avatarImage: connection.avatarPhoto ?? UIImage(imageLiteralResourceName: "avatar-placeholder"))
                                Text(connection.fullName)
                            }
                            
                        }
                        //ListViewComponent(item: "avatar", size: 50)
                        Button(action: {
                            showingAddContact = true
                        })
                        { Image("icon-add") }
                        Spacer(minLength: 20)
                    }
                    Spacer()
                }
                
                VStack {
                    /* Button("Create new event", action: { showingCreateEvent = true } )
                     .sheet(isPresented: $showingCreateEvent) {
                     CreateEventView()
                     } */
                    
                    Form {
                        UserDetailsComponent()
                    }
                }
                
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
                }
            }
            .onAppear {
                ProfileVM.getProfileForCurrentUser()
                FileVM.fetchPhoto(avatarUrlFetched: appState.profile!.avatar)
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
