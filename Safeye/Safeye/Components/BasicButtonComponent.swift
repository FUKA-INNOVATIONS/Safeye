//
//  ButtonComponent.swift
//  Safeye
//
//  Created by Safeye Team on 1.4.2022.
//

/* An other option would be to have folder for each component including View and modifiers */


import SwiftUI

struct BasicButtonComponent: View {
    // @Binding var action: Any
    let label: LocalizedStringKey
    let action: () -> Void
    
    // This is the parent
    // Bind it here
    
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                action()
            } label: {
                Text(label)
            }
        }
        .modifier(BasicButtonModifier())
    }
}

