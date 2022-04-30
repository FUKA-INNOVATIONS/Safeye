//
//  MapCurtainComponent.swift
//  Safeye
//
//  Created by dfallow on 9.4.2022.
//

import SwiftUI

struct MapCurtainComponent: View {
    var body: some View {
        
        VStack {
    
            HStack {
                Spacer()
                Text("Trusted Contacts")
                    .padding(.top, 15)
                    .font(.headline)
                Spacer()
            }
            
            CurtainTCListComponent()
            
        }
        .modifier(CurtainModifier())
        
    }
}

struct MapCurtainComponent_Previews: PreviewProvider {
    static var previews: some View {
        MapCurtainComponent()
    }
}
