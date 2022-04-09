//
//  CurtainTCComponent.swift
//  Safeye
//
//  Created by dfallow on 9.4.2022.
//

import SwiftUI

struct CurtainTCComponent: View {
    var body: some View {
        HStack {
            AvatarComponent(size: 50)
            Spacer()
            Text("Name Surname")
            Spacer()
            BasicButtonComponent(label: "Focus") {
                
            }
        
        }.padding(10)
    }
}

struct CurtainTCComponent_Previews: PreviewProvider {
    static var previews: some View {
        CurtainTCComponent()
    }
}
