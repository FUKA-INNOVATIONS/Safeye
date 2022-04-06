//
//  ButtonComponent.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//

/* An other option would be to have folder for each component including View and modifiers */


import SwiftUI

struct BasicButtonComponent: View {
    // @Binding var action: Any
    let label: String
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

/* struct BasicButtonComponent_Previews: PreviewProvider {
    @State var inputText: String = "Hello input"
    
    static var previews: some View {
        BasicButtonComponent(label: " Say Hello ")
    }
} */
