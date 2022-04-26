//
//  TrustContactDetailsComponent.swift
//  Safeye
//
//  Created by gintare on 24.4.2022.
//

import SwiftUI

struct TrustContactDetailsComponent: View {
    var profile: ProfileModel
    
    init(profile: ProfileModel) {
        self.profile = profile
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Image(systemName: "house.circle.fill")
                    .font(.system(size: 30))
                Text(profile.address)
                    .padding()
                Spacer()
            }
            HStack{
                Image(systemName: "person.badge.clock.fill")
                    .font(.system(size: 30))
                Text("Born: \(profile.birthday)")
                    .padding()
            }
     
            HStack{
                Image(systemName: "stethoscope.circle.fill")
                    .font(.system(size: 30))
                VStack(alignment: .leading){
                    Text("Blood type: \(profile.bloodType)")
                    Text("Illness: \(profile.illness)")
                    Text("Allergies: \(profile.allergies)")
                }
                .padding()
            }
        }
    }
    
}
