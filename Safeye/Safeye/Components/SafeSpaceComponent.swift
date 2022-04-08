//
//  SafeSpaceComponent.swift
//  Safeye
//
//  Created by gintare on 8.4.2022.
//

import SwiftUI

struct SafeSpaceComponent: View {
    let size: CGFloat
    init (size: CGFloat) {
        self.size = size
    }
    
        var body: some View {
            Image("icon-house")
                .frame(width: size, height: size, alignment: .center)
                .scaledToFit()
                .aspectRatio(contentMode: .fill)
        }
}

struct SafeSpaceComponent_Previews: PreviewProvider {
    static var previews: some View {
        SafeSpaceComponent(size: 100)
    }
}
