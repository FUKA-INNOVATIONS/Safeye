//
//  CurtainTCListComponent.swift
//  Safeye
//
//  Created by dfallow on 9.4.2022.
//

import SwiftUI

struct CurtainTCListComponent: View {
        var body: some View {
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    ForEach(0..<5) {_ in
                        CurtainTCComponent()
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
