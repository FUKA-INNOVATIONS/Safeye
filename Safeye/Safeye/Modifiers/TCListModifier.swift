//
//  TCListModifier.swift
//  Safeye
//
//  Created by dfallow on 9.4.2022.
//

import SwiftUI

struct TCListModifier: ViewModifier {
    func body(content: Content) -> some View {
            content
                .padding(10)
                .frame(height: 350)
        }
}
