//
//  SecureInputFieldComponent.swift
//  Safeye
//
//  Created by Safeye Team on 1.4.2022.
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
            }.padding()
            .background(.bar)
            .cornerRadius(10)
        }.padding()
    }
}

