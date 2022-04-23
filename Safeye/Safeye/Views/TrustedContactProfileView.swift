//
//  TrustedContactProfileView.swift
//  Safeye
//
//  Created by gintare on 19.4.2022.
//

import SwiftUI

struct TrustedContactProfileView: View {
    @EnvironmentObject var ProfileVM: ProfileViewModel
    @EnvironmentObject var appState: Store
    @EnvironmentObject var FileVM: FileViewModel
    
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
                        if appState.trustecContactPhoto != nil {
                            ProfileImageComponent(size: 100, avatarImage: appState.trustecContactPhoto!)
                        } else {
                            ProgressView()
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
                FileVM.fetchPhoto(avatarUrlFetched: appState.trustedContactProfile?.avatar, isTrustedContactPhoto: true)
            }
        }
    }
}

