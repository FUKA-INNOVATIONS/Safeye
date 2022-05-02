//
//  LoginInputComponent.swift
//  Safeye
//
//  Created by Safeye Team on 1.4.2022.
//


import SwiftUI

struct LoginInputComponent: View {
    let title: LocalizedStringKey
    @Binding var inputText: String
    var icon: String
    
    var body: some View {
        
        VStack {
            HStack {
                Image(systemName: "\(icon)")
                    .foregroundColor(.secondary)
                
                TextField(title, text: $inputText)
            }   .padding()
                .background(.bar)
                .cornerRadius(10)
            
        }   .padding()
    }
}
