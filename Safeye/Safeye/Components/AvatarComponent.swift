//
//  AvatarComponent.swift
//  Safeye
//
//  Created by gintare on 6.4.2022.
//

import SwiftUI

struct AvatarComponent: View {
    let avatarURL = URL(string: "https://i.pravatar.cc/100")!
    
    let size: CGFloat
    init (size: CGFloat) {
        self.size = size
    }
    
        var body: some View {
            
            AsyncImage(url: avatarURL) { phase in
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
            .avatarImage(size: size)
        }
}

struct AvatarComponent_Previews: PreviewProvider {
    static var previews: some View {
        AvatarComponent(size: 50)
    }
}

extension View {
    func avatarImage(size: CGFloat) -> some View {
        modifier(AvatarModifier(size: size))
    }
}
