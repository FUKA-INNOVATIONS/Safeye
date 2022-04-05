//
//  secureInputFieldModifier.swift
//  Safeye
//
//  Created by Koulu on 5.4.2022.
//

import SwiftUI

struct inputFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
            content
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .padding()
        }
}
