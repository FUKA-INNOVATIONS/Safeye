//
//  TCProfileView.swift
//  Safeye
//
//  Created by Safeye Team on 1.4.2022.
//
/*
 Here you can see the person you added as Trusted contacts, you can access this from Connection view
 */
import SwiftUI

struct TCProfileView: View {
    @EnvironmentObject var ProfileVM: ProfileViewModel
    @EnvironmentObject var FileVM: FileViewModel
    @EnvironmentObject var appState: Store
    
    var body: some View {
        VStack {
            Spacer(minLength: 30)
            VStack {
                if appState.trustedContactPhoto != nil {
                    ProfileImageComponent(size: 150, avatarImage: appState.trustedContactPhoto!)
                } else {
                    ProgressView()
                }
                Text(appState.tCProfile?.fullName ?? "").font(.title).padding()
                
            }
            TrustContactDetailsComponent(profile: appState.tCProfile!)
            Spacer()
        }
    }
}
