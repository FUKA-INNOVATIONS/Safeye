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
                Text("\(viewModel.profileDetails?.address ?? "Homeless")")
            }
            HStack{
                Image("icon-add")
                Text("\(viewModel.profileDetails?.birthday ?? "Still in mama's stomach")")
            }
            HStack{
                Image("icon-add")
                VStack(alignment: .leading){
                    Text("\(viewModel.profileDetails?.bloodType ?? "Water engine")")
                    Text("\(viewModel.profileDetails?.illness ?? "Are you serious")")
                    Text("\(viewModel.profileDetails?.allergies ?? "Teachers who teaches for only getting salary")")
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
