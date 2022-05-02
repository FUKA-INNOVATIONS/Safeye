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

            GroupBox {
//                DisclosureGroup("Person details") { // TODO: translation
                DisclosureGroup(translationManager.personDetails) {
                    HStack{
//                        Text("Address")
                        Spacer()
                        Text("\(profile.address)")
                    }
                    .padding(.top, 15)
                    .font(.subheadline)
                    
                    HStack{
                        Text("\(Text(translationManager.bornTitle))")
                        Spacer()
                        Text("\(profile.birthday)")
                    }
                    .padding(.top, 10)
                    .font(.subheadline)
                }
                .font(.headline)
            }
                        
            GroupBox {
//                DisclosureGroup("Health details") { // TODO: translation
                DisclosureGroup(translationManager.healthDetails) {
                    HStack {
                        Text(translationManager.illnessTitle)
                        Spacer()
                        Text(profile.illness)
                    }
                    .padding(.top, 15)
                    .font(.subheadline)

                    HStack {
                        Text(translationManager.allergiesTitle)
                        Spacer()
                        Text(profile.allergies)

                    }
                    .padding(.top, 10)
                    .font(.subheadline)

                    HStack {
                        Text(translationManager.bloodTitle)
                        Spacer()
                        Text(profile.bloodType)
                    }
                    .padding(.top, 10)
                    .font(.subheadline)
                }
                .font(.headline)
            }

        }
        .padding()
        
        
        
//        VStack(alignment: .leading) {
//            HStack{
//                Image(systemName: "house.circle.fill")
//                    .font(.system(size: 30))
//                Text(profile.address)
//                    .padding()
//                Spacer()
//            }
//            HStack{
//                Image(systemName: "person.badge.clock.fill")
//                    .font(.system(size: 30))
//                Text("Born: \(profile.birthday)")
//                    .padding()
//            }
//
//            HStack{
//                Image(systemName: "stethoscope.circle.fill")
//                    .font(.system(size: 30))
//                VStack(alignment: .leading){
//                    Text("Blood type: \(profile.bloodType)")
//                    Text("Illness: \(profile.illness)")
//                    Text("Allergies: \(profile.allergies)")
//                }
//                .padding()
//            }
//        }
    }
    
}
