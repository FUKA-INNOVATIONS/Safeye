//
//  UserDetailsComponent.swift
//  Safeye
//
//  Created by gintare on 7.4.2022.
//

import SwiftUI

struct UserDetailsComponent: View {
        var body: some View {
            VStack(alignment: .leading) {
                HStack{
                    Image("icon-add")
                    Text("123 High Street, Helsinki, Finland")
                }
                HStack{
                    Image("icon-add")
                    Text("Birthday: 01-01-2001")
                }
                HStack{
                    Image("icon-add")
                    VStack(alignment: .leading){
                        Text("Blood type: A+")
                        Text("Illness: asthma")
                        Text("Allergies: peanuts, sesame, onions")
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
