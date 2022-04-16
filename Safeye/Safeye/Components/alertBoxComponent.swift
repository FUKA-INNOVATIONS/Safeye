//
//  alertBoxComponent.swift
//  Safeye
//
//  Created by Pavlo Leinonen on 15.4.2022.
//

import SwiftUI

struct alertBoxComponent: View {
    
    @Binding var buttonIsPressed: Bool
    var title: String = "Please confirm"
    
    var onComfirm: () -> Void = { } //TODO activating mode after pressing
    var onCancel: () -> Void = { }
    
    var body: some View {
        VStack {
            Text(title)
            HStack {
                Button("Confirm") {
                    buttonIsPressed = false
                    self.onComfirm()
                }
                .fixedSize(horizontal: true, vertical: true)
                Button("Cancel") {
                    buttonIsPressed = false
                    self.onCancel()
                }
            }
        }
        .padding()
        .frame(
            width: 250,
            height: 150)
        .background(Color(red: 255, green: 255, blue: 255))
        .clipShape(RoundedRectangle(cornerRadius: 20.0,
                                    style: .continuous))
        .offset(y: buttonIsPressed ? 0 : 300)
//        .animation(.easeInOut, value: buttonIsPressed)
        .shadow(color: Color(red: 0, green: 0, blue: 0), radius: 4, x: -1, y: -1)
    }
}

struct alertBoxComponent_Previews: PreviewProvider {
    static var previews: some View {
        alertBoxComponent(buttonIsPressed: .constant(true))
    }
}
