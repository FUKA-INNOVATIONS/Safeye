//
//  UserDetailsComponent.swift
//  Safeye
//
//  Created by gintare on 7.4.2022.
//  Edited by FUKA on 8.4.2022.
//

import SwiftUI

struct UserDetailsComponent: View {
    @ObservedObject var viewModel = ProfileViewModel()
    
    init() {
        viewModel.getProfile()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Image("icon-add")
                Text("Address: \(viewModel.profileDetails?.address ?? "Homeless")")
            }
            HStack{
                Image("icon-add")
                Text("Born: \(viewModel.profileDetails?.birthday ?? "Still in mama's stomach")")
            }
            HStack{
                Image("icon-add")
                VStack(alignment: .leading){
                    Text("Blood type: \(viewModel.profileDetails?.bloodType ?? "Water engine")")
                    Text("Illness: \(viewModel.profileDetails?.illness ?? "Are you serious")")
                    Text("Allergies: \(viewModel.profileDetails?.allergies ?? "Teachers who teaches for only getting salary")")
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
