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
            HStack{
                Image(systemName: "house.circle.fill")
                    .font(.system(size: 30))
                Text("\(appState.profile?.address ?? "Homeless")")
                    .padding()
            }
            HStack{
                Image(systemName: "person.badge.clock.fill")
                    .font(.system(size: 30))
                Text("\(Text(translationManager.bornTitle)) \(appState.profile?.birthday ?? "Still in mama's stomach")")
                    .padding()
            }
     
            HStack{
                Image(systemName: "stethoscope.circle.fill")
                    .font(.system(size: 30))
                VStack(alignment: .leading){
                    Text("\(Text(translationManager.bloodTitle)) \(appState.profile?.bloodType ?? "Water engine")")
                    Text("\(Text(translationManager.illnessTitle)) \(appState.profile?.illness ?? "Are you serious")")
                    Text("\(Text(translationManager.allergiesTitle)) \(appState.profile?.allergies ?? "Teachers who teaches for only getting salary")")
                }
                .padding()
            }
        }
    }
    
}

struct UserDetailsComponent_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailsComponent()
    }
}
