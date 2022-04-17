//
//  ProfileImageComponent.swift
//  Safeye
//
//  Created by gintare on 17.4.2022.
//

import SwiftUI

struct ProfileImageComponent: View {

    var size: CGFloat = 70
    var avatarImage: UIImage
    
    init (size: CGFloat, avatarImage: UIImage) {
        self.size = size
        self.avatarImage = avatarImage
    }
    
        var body: some View {
            Image(uiImage: avatarImage)
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .frame(width: size, height: size)
        }
}

//struct ProfileImageComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileImageComponent(size: 90, avatarImage: UIImage(imageLiteralResourceName: "avatar-placeholder"))
//    }
//}

//extension View {
//    func profileImage(size: CGFloat) -> some View {
//        modifier(AvatarModifier(size: size))
//    }
//}
