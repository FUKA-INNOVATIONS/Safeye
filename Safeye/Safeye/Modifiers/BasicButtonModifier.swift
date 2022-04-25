//
//  buttonModifier.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//

import SwiftUI

struct BasicButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
            content
                .foregroundColor(Color.white)
                .frame(width: 200, height: 50)
                .cornerRadius(40)
                .background(Color.blue)
                .clipShape(Capsule())
                .padding()
        }
}
