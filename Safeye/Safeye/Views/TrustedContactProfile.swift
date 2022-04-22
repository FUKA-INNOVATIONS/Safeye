//
//  TrustedContactProfile.swift
//  Safeye
//
//  Created by gintare on 19.4.2022.
//

import SwiftUI

struct TrustedContactProfile: View {
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
    @State var fetchedPhoto: UIImage?
    
    var profileID: String
    
    init(profileID: String) {
        self.profileID = profileID
    }
    
    var body: some View {
        
        ZStack {
            VStack {
                
                Group{
                    // Display profile photo
                    VStack {
                        Text(appState.trustedContactProfile?.fullName ?? "No name")
                        if FileVM.fetchedPhoto != nil {
                            ProfileImageComponent(size: 100, avatarImage: FileVM.fetchedPhoto!)
                        } else {
                            ProfileImageComponent(size: 70, avatarImage: UIImage(imageLiteralResourceName: "avatar-placeholder"))
                        }
                    }
                    Spacer()
                }
                
                
                
                Spacer()
                
                VStack {
                    Form {
                        UserDetailsComponent(isTrustedContact: true)
                    }
                }
            }
            .onAppear {
                ProfileVM.getTrustedContactProfile(trustedContactID: profileID)
                //FileVM.fetchPhoto(avatarUrlFetched: appState.profile!.avatar)
                //fetchedPhoto = FileVM.fetchedPhoto
            }
        }
    }
}

