//
//  InputComponent.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//

/* An other option would be to have folder for each component including View and modifiers */


import SwiftUI

struct InputFieldComponent: View {
    let title: LocalizedStringKey
    @Binding var inputText: String
    
    // This is the parent
    // Bind it here

        var body: some View {
            VStack(alignment: .leading) {
                Text(title)
                TextField(title, text: $inputText)
            }
            .modifier(inputFieldModifier())
        }
}


struct InputFieldComponent_Previews: PreviewProvider {
    @State var inputText: String = "Hello input"
    
    static var previews: some View {
        InputFieldComponent(title: "Email address", inputText: .constant("hello binding"))
    }
}
