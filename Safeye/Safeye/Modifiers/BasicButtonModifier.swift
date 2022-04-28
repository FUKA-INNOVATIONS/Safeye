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
                .buttonStyle(.bordered)
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 4.0))
                .foregroundColor(.blue)
                .padding()
        }
}
