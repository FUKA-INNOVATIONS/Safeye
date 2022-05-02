//
//  MapCurtainComponent.swift
//  Safeye
//
//  Created by dfallow on 9.4.2022.
//

import SwiftUI

struct MapCurtainComponent: View {
    var translationManager = TranslationService.shared

    var body: some View {
        
        VStack {
    
            HStack {
                Spacer()

                Text("^   \(translationManager.trustedContactsMap)  ^")
                    .padding(.top, 30)
                    .font(.title2)
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
