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
            .background(Color(UIColor.systemGray4))
            .cornerRadius(10)
            .padding([.leading, .trailing], 10)
            .foregroundColor(Color.black)
        }
}
