//
//  panicButtonModifier.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//

import SwiftUI

struct panicButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
            content
            .frame(width: 100, height: 100)
            .foregroundColor(Color.black)
            .background(Color.red)
            .clipShape(Circle())
        }
}
