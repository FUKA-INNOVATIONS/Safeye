//
//  TCItemModifier.swift
//  Safeye
//
//  Created by dfallow on 9.4.2022.
//

import SwiftUI

struct TCItemModifier: ViewModifier {
    func body(content: Content) -> some View {
            content
            .foregroundColor(Color.black)
            .font(.title3)
            .padding(.vertical, 20)
            .padding(.horizontal, 40)
            .background(Color.white)
            .cornerRadius(5)
        }
}
