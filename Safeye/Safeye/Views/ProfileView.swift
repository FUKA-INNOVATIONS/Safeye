//
//  ProfileView.swift
//  Safeye
//
//  Created by Safeye Team on 1.4.2022.
//
/*
Profile view includes user's info, and user's safe places and a navigation to add safe places, also edit profile info, and shows the info about the user.
 */

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var ProfileVM: ProfileViewModel
    @EnvironmentObject var ConnectionVM: ConnectionViewModel
    @EnvironmentObject var appState: Store
    @EnvironmentObject var FileVM: FileViewModel
    @EnvironmentObject var EventVM: EventViewModel
    @EnvironmentObject var SafePlaceVM: SafePlaceViewModel
    var translationManager = TranslationService.shared
    @State private var showingEditProfile = false
    @State private var showingAddSafePlace = false
    @State var isImagePickerShowing = false
    @State var selectedPhoto: UIImage?
    
    var body: some View {
        
        return ZStack {
            ScrollView {
                VStack {
                    // display profile photo
                    if appState.userPhoto != nil {
                        ProfileImageComponent(size: 150, avatarImage: appState.userPhoto!)
                            .padding(.bottom)
                    } else {
                        ProgressView()
                    }
                    
                    HStack {
                        // display full name
                        Text("\(appState.profile?.fullName ?? "No name")")
                            .font(.system(size: 35, weight: .bold))
                            .lineLimit(1)
                            .padding(5)
                            .padding(.leading, 10)
                        
                        
                        // edit profile button
                        Button { showingEditProfile = true } label: {
                            //Text("Edit profile")
                            Image(systemName: "pencil.and.outline")
                        }
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.blue)
                        .padding(.bottom, 15)
                        
                        .sheet(isPresented: $showingEditProfile) {
                            ProfileEditView()
                        }
                    }
                }
                
                Spacer(minLength: 30)
                
                // Safe Spaces
                VStack {
                    
                    Text("My safe spaces")
                        .fontWeight(.bold)
                    
                    
                    if appState.safePlaces.isEmpty { Text("You haven't yet added any places").font(.caption).padding(.top) }
                    
                    ListViewComponent(item: "safeSpace", size: 40)
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                    
                    HStack{
                        Spacer()
                        
                        NavigationLink {
                            MapView()
                        } label: {
                            Text("View on map")
                            
                            Image(systemName: "paperplane")
                        }
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.blue)
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation { showingAddSafePlace = true }
                            print("modal: ($showingAddSafePlace)")
                        })
                        { //Image(systemName: "plus.magnifyingglass")
                            Text("Add new")
                            Image(systemName: "plus.magnifyingglass")
                        }
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.blue)
                        
                        Spacer()
                    }
                    
                }
                UserDetailsComponent() // Personal and health info
                    .padding(.top, 10)
            }
            .onAppear {
                print("profileView view appeared")
                ProfileVM.getProfileForCurrentUser()
                FileVM.fetchPhoto(avatarUrlFetched: appState.profile!.avatar)
            }
            AddSafePlaceView(isShowing: $showingAddSafePlace)
        }
        .onAppear {
            EventVM.sendNotification()
            SafePlaceVM.getSafePlacesOfAuthenticatedtUser()
        }
        
    }
}
