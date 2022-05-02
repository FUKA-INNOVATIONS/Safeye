//
//  TCProfileView.swift
//  Safeye
//
//  Created by gintare on 24.4.2022.
//

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
