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
    var translationManager = TranslationService.shared
    
    @State private var showingEditProfile = false
    @State private var showingAddSafePlace = false
    
    @State var isImagePickerShowing = false
    @State var selectedPhoto: UIImage?
    
    var body: some View {
        
        return ZStack {
            VStack {
                
                VStack {
                    
                    // display full name
                    Text("\(appState.profile?.fullName ?? "No name")")
                        .font(.system(size: 25, weight: .bold))
                        .lineLimit(1)
                        .padding(5)
                        .padding(.leading, 10)
                    
                    // display profile photo
                    if appState.userPhoto != nil {
                        ProfileImageComponent(size: 100, avatarImage: appState.userPhoto!)
                            .padding(.bottom)
                    } else {
                        ProgressView()
                    }
                }
                
                // edit profile button
                Button { showingEditProfile = true } label: {
                    Text("Edit profile")
                    //Image(systemName: "pencil")
                }
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(.blue)
                .padding(.bottom, 15)
                
                .sheet(isPresented: $showingEditProfile) {
                    ProfileEditView()
                }
                Divider()
                Spacer(minLength: 30)
                
                // Safe Spaces
                VStack {
                    
                    Text("My safe spaces")
                        .fontWeight(.bold)
                    
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
                Spacer(minLength: 40)
                Divider()
                Text("My details")
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                ScrollView {
                    UserDetailsComponent()
                }
   
            }
            //.padding(.top, -100)
            .onAppear {
                print("profileView view appeared")
                ProfileVM.getProfileForCurrentUser()
                FileVM.fetchPhoto(avatarUrlFetched: appState.profile!.avatar)
                //ProfileVM.updateUserHomeCoordinates()
            }
            AddSafePlaceView(isShowing: $showingAddSafePlace)
        }
//        .navigationTitle("")
//        .navigationBarHidden(true)
        .onAppear {
            //            ConnectionVM.getConnections()
            //            ConnectionVM.getConnectionProfiles()
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
