//
//  SecureInputFieldComponent.swift
//  Safeye
//
//  Created by Koulu on 5.4.2022.
//

import SwiftUI

struct SecureInputFieldComponent: View {
    
    let title: LocalizedStringKey
    @Binding var secureText: String
    

    @State private var showPassword = false

    var body: some View {
        VStack{
        HStack {
            Image(systemName: "lock")
                .foregroundColor(.secondary)
            if showPassword {
                TextField(title, text: $secureText)
            } else {
            SecureField(title,
                      text: $secureText)
            }
            Button(action: { self.showPassword.toggle()}) {
                
                Image(systemName: "eye")
                .foregroundColor(.secondary)
            }
        }    .padding()
            .background(.bar)
            .cornerRadius(10)
        } .padding()
}
}
//struct SecureInputFieldComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        SecureInputFieldComponent(title: "Password", secureText: .constant("12445"))
//    }
//}
