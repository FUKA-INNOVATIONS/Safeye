//
//  SecureInputFieldComponent.swift
//  Safeye
//
//  Created by Koulu on 5.4.2022.
//

import SwiftUI

struct SecureInputFieldComponent: View {
    
    let title: String
    @Binding var secureText: String
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
            SecureField(title, text: $secureText)
        }
        .modifier(inputFieldModifier())
    }
}

struct SecureInputFieldComponent_Previews: PreviewProvider {
    static var previews: some View {
        SecureInputFieldComponent(title: "Password", secureText: .constant("12445"))
    }
}
