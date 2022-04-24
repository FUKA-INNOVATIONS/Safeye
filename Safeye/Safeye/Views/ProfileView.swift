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
    @EnvironmentObject var connService: ConnectionService
    @EnvironmentObject var EventVM: EventViewModel
    @EnvironmentObject var SafePlaceVM: SafePlaceViewModel
    
    @State private var showingEditProfile = false
    @State private var showingAddContact = false
    @State private var showingAddSafePlace = false
    
    @State var isImagePickerShowing = false
    @State var selectedPhoto: UIImage?
    
    var body: some View {
        
        return ZStack {
            VStack {
                
                Group{
                    // AvatarComponent(size: 80)
                    
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
                    
                    Group {
                        Spacer()
                        HStack {
                            Spacer()
                            ForEach(appState.allContactsWithPhotos) { contact in
                                VStack {
                                    if contact.avatarPhoto != nil {
                                        ProfileImageComponent(size: 50, avatarImage: contact.avatarPhoto!)
                                    } else {
                                        ProgressView()
                                            
                                    }
        
                                    Text(contact.fullName)

                                }
                                Spacer()
                            }
                            Spacer()
                            Button(action: {
                                showingAddContact = true
                            })
                            { Image(systemName: "plus.magnifyingglass")
                                    .font(.system(size: 30))
                            }
                            Spacer()
                        }
                    }
                    
  
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
                    NavigationLink {
                        MapView()
                    } label: {
                        Text("My safe spaces").font(.system(size: 18, weight: .semibold))//.foregroundColor(.black)
                    }

                    HStack{
                        //size with icons doesn't work properly, will figure this out later
                        ListViewComponent(item: "safeSpace", size: 40)
                        Button(action: {
                            showingAddSafePlace = true
                            print("modal: ($showingAddSafePlace)")
                        })
                        { Image(systemName: "plus.magnifyingglass")
                                .font(.system(size: 30))
                        }
                        Spacer(minLength: 20)
                    }
                }
                
                
            }
            .onAppear {
                print("profileView view appeared")
                //ProfileVM.updateUserHomeCoordinates()
            }
            AddContactView(isShowing: $showingAddContact, searchInput: "")
            AddSafePlaceView(isShowing: $showingAddSafePlace)
        }
        .onAppear {
            ProfileVM.getProfileForCurrentUser()
            FileVM.fetchPhoto(avatarUrlFetched: appState.profile!.avatar)
            ConnectionVM.getConnections()
            ConnectionVM.getConnectionProfiles()
            ConnectionVM.getPendingRequests()
            EventVM.sendNotification()
            SafePlaceVM.getSafePlacesOfAuthenticatedtUser()
        }
        
    }
}

/*struct ProfileView_Previews: PreviewProvider {
 static var previews: some View {
 ProfileView()
 }
 }*/
