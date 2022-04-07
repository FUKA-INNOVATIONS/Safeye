//
//  PanicButtonComponent.swift
//  Safeye
//
//  Created by Pavlo Leinonen on 7.4.2022.
//

import SwiftUI

struct PanicButtonComponent: View {
    
    var body: some View {
            Button(action: {
                print("Round Action")
                }) {
                Text("PANIC")
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color.black)
                    .background(Color.red)
                    .clipShape(Circle())
            }
        }
    }

struct PanicButtonComponent_Preview: PreviewProvider {
    static var previews: some View {
        PanicButtonComponent()
    }
}

