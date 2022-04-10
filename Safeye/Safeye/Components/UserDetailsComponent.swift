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

    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Image("icon-add")
                Text("Address: \(profileVM.profileDetails?.address ?? "Homeless")")
            }
            HStack{
                Image("icon-add")
                Text("Born: \(profileVM.profileDetails?.birthday ?? "Still in mama's stomach")")
            }
            HStack{
                Image("icon-add")
                VStack(alignment: .leading){
                    Text("Blood type: \(profileVM.profileDetails?.bloodType ?? "Water engine")")
                    Text("Illness: \(profileVM.profileDetails?.illness ?? "Are you serious")")
                    Text("Allergies: \(profileVM.profileDetails?.allergies ?? "Teachers who teaches for only getting salary")")
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
