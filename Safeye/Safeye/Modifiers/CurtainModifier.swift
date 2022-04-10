//
//  CurtainModifier.swift
//  Safeye
//
//  Created by dfallow on 9.4.2022.
//

import SwiftUI

struct CurtainModifier: ViewModifier {
    func body(content: Content) -> some View {
            content
                .background(Color.gray)
                .cornerRadius(40)
                .padding([.leading, .trailing], 10)
                .foregroundColor(Color.white)
        }
}
