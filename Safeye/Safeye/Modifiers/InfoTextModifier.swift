//
//  InfoTextModifier.swift
//  Safeye
//
//  Created by gintare on 28.4.2022.
//

import SwiftUI

struct InfoTextModifier: ViewModifier {
    var alignment: TextAlignment = .leading

    func body(content: Content) -> some View {
            content
            .multilineTextAlignment(alignment)
            .lineSpacing(10)
            .padding()
    }
}
