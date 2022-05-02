//
//  ProfileImageComponent.swift
//  Safeye
//
//  Created by Safeye Team on 1.4.2022.
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
