//
//  InputComponent.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//

/* An other option would be to have folder for each component including View and modifiers */


import SwiftUI

struct InputFieldComponent: View {
    @State var title: String
    @State var text: String

        var body: some View {
            VStack(alignment: .leading) {
                Text(title)
                TextField(title, text: $text)
            }
            .modifier(inputFieldModifier())
        }
}


struct InputFieldComponent_Previews: PreviewProvider {
    static var previews: some View {
        InputFieldComponent(title: "Email address", text: "")
    }
}
