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

    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Image("icon-add")
                Text("Address: \(appState.profile?.address ?? "Homeless")")
            }
            HStack{
                Image("icon-add")
                Text("Born: \(appState.profile?.birthday ?? "Still in mama's stomach")")
            }
            HStack{
                Image("icon-add")
                VStack(alignment: .leading){
                    Text("Blood type: \(appState.profile?.bloodType ?? "Water engine")")
                    Text("Illness: \(appState.profile?.illness ?? "Are you serious")")
                    Text("Allergies: \(appState.profile?.allergies ?? "Teachers who teaches for only getting salary")")
                }
            }
        }
    }
    
}

struct UserDetailsComponent_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailsComponent()
    }
}
