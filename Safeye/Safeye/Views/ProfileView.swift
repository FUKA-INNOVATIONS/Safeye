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
    @EnvironmentObject var SafePlaceVM: SafePlaceViewModel
    
    @State private var showingEditProfile = false
    @State private var showingAddContact = false
    @State private var showingAddSafePlace = false
    
    @State var isImagePickerShowing = false
    @State var selectedPhoto: UIImage?
    @State var fetchedPhoto: UIImage?
    
    var body: some View {
        
        return ZStack {
            VStack {
                
                Group{
                    // AvatarComponent(size: 80)
                    
                    // Display profile photo
                    VStack {
                        // if user already has a profile photo, display that
                        if FileVM.fetchedPhoto != nil {
                            ProfileImageComponent(size: 100, avatarImage: FileVM.fetchedPhoto!)
                        } else {
                            // if they don't have it, display placeholder image
                            // this technically shouldn't be needed because we are forcing them to upload an image. However, at the moment the fetching is a bit buggy and sometimes it shows this placeholder.
                            ProfileImageComponent(size: 70, avatarImage: UIImage(imageLiteralResourceName: "avatar-placeholder"))
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
                print("profileView view appeared")
                ProfileVM.getProfileForCurrentUser()
                FileVM.fetchPhoto(avatarUrlFetched: appState.profile!.avatar)
                fetchedPhoto = FileVM.fetchedPhoto
                //ProfileVM.updateUserHomeCoordinates()
            }
            AddContactView(isShowing: $showingAddContact, searchInput: "")
            AddSafePlaceView(isShowing: $showingAddSafePlace)
        }
        .onAppear {
            ConnectionVM.getConnections()
            ConnectionVM.getConnectionProfiles()
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
