//
//  inputFieldModifier.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//

import SwiftUI

struct InputFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
            content
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .padding()
        }
}
