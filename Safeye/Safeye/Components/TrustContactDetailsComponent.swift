//
//  TrustContactDetailsComponent.swift
//  Safeye
//
//  Created by gintare on 24.4.2022.
//

import SwiftUI

struct TrustContactDetailsComponent: View {
    var profile: ProfileModel
    var translationManager = TranslationService.shared
    
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
                Text(translationManager.bornTitle)
                Text(profile.birthday)
                    .padding()
            }
     
            HStack{
                Image(systemName: "stethoscope.circle.fill")
                    .font(.system(size: 30))
                VStack(alignment: .leading){
                    HStack{
                        Text(translationManager.bloodTitle)
                        Text(profile.bloodType)
                    }
                    HStack {
                        Text(translationManager.illnessTitle)
                        Text(profile.illness)
                    }
                    HStack {
                        Text(translationManager.allergiesTitle)
                        Text(profile.allergies)
                    }
                   
                }
                .padding()
            }
        }
    }
    
}
