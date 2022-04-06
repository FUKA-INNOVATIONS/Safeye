//
//  avatarModifier.swift
//  Safeye
//
//  Created by gintare on 6.4.2022.
//

import SwiftUI

struct AvatarModifier: ViewModifier {
    let size: CGFloat
    func body(content: Content) -> some View {
            content
            .scaledToFit()
            .frame(width: size, height: size, alignment: .topLeading)
            .clipShape(Circle())
            .aspectRatio(contentMode: .fit)
    }
}
