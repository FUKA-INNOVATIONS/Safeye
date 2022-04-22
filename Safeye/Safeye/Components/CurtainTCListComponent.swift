//
//  CurtainTCListComponent.swift
//  Safeye
//
//  Created by dfallow on 9.4.2022.
//

import SwiftUI

struct CurtainTCListComponent: View {
    
    @EnvironmentObject var appState: Store
    
        var body: some View {
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    ForEach(appState.connectionPofiles) { connectionProfile in
                        CurtainTCComponent(trustedContact: connectionProfile)
                    }
                }
            }
                .modifier(TCListModifier())
        }
}

struct CurtainTCListComponent_Previews: PreviewProvider {
    static var previews: some View {
        CurtainTCListComponent()
    }
}
