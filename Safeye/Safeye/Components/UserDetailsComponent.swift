//
//  UserDetailsComponent.swift
//  Safeye
//
//  Created by gintare on 7.4.2022.
//  Edited by FUKA on 8.4.2022.
//

import SwiftUI

struct UserDetailsComponent: View {
    @EnvironmentObject var profileVM: ProfileViewModel
    @EnvironmentObject var appState: Store
    
    var translationManager = TranslationService.shared
    
    var body: some View {
        VStack(alignment: .leading) {

            GroupBox {
                DisclosureGroup(translationManager.healthDetail) {
                    HStack{
//                        Text("Address")
                        Text(translationManager.addressTitle)
                        Spacer()
                        Text("\(appState.profile?.address ?? "Homeless")")
                    }
                    .padding(.top, 15)
                    .font(.subheadline)
                    
                    HStack{
                        Text("\(Text(translationManager.bornTitle))")
                        Spacer()
                        Text("\(appState.profile?.birthday ?? "Still in mama's stomach")")
                    }
                    .padding(.top, 10)
                    .font(.subheadline)
                }
                .font(.headline)
            }
                        
            GroupBox {
                DisclosureGroup(translationManager.healthDetail) { 
                    HStack {
                        Text("\(Text(translationManager.illnessTitle))")
                        Spacer()
                        Text("\(appState.profile?.illness ?? "Are you serious?")")
                    }
                    .padding(.top, 15)
                    .font(.subheadline)

                    HStack {
                        Text("\(Text(translationManager.allergiesTitle)) ")
                        Spacer()
                        Text("\(appState.profile?.allergies ?? "Teachers who teaches for only getting salary")")

                    }
                    .padding(.top, 10)
                    .font(.subheadline)

                    HStack {
                        Text("\(Text(translationManager.bloodTitle))")
                        Spacer()
                        Text("\(appState.profile?.bloodType ?? "Water engine")")
                    }
                    .padding(.top, 10)
                    .font(.subheadline)
                }
                .font(.headline)
            }

        }
        .padding()
    }
    
}

struct UserDetailsComponent_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailsComponent()
    }
}
