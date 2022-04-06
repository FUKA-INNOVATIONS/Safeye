//
//  AvatarComponent.swift
//  Safeye
//
//  Created by gintare on 6.4.2022.
//

import SwiftUI

struct AvatarComponent: View {

        var body: some View {
            AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png")) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                } else if phase.error != nil {
                    Text("There was an error loading the image.")
                } else {
                    ProgressView()
                }
            }
            .avatarImage(size: 100)
        }
}

struct AvatarComponent_Previews: PreviewProvider {
    static var previews: some View {
        AvatarComponent()
    }
}

extension View {
    func avatarImage(size: CGFloat) -> some View {
        modifier(AvatarModifier(size: size))
    }
}
