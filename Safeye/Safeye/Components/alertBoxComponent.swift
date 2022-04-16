//
//  alertBoxComponent.swift
//  Safeye
//
//  Created by Pavlo Leinonen on 15.4.2022.
//
import UIKit
import SwiftUI

struct alertBoxComponent: View {
    @EnvironmentObject var appState: Store
    //    @Binding var buttonIsPressed: Bool
    var title: String = "Please confirm"
    let screenSize = UIScreen.main.bounds
    @Binding var text:String
    
    var onComfirm: () -> Void = { } //TODO activating mode after pressing
    var onCancel: () -> Void = { }
    
    var body: some View {
        VStack {
            Text(title)
            Spacer()
            HStack {
                Button("Confirm") {
                    // buttonIsPressed = false
                    // self.onComfirm()
                }
                Spacer()
                Button("Cancel") {
                    // buttonIsPressed = false
                    // self.onCancel()
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
        .offset(y: appState.panicMode ? 0 : screenSize.height)
        .animation(.easeInOut, value: appState.panicMode)
        .shadow(color: Color(red: 0, green: 0, blue: 0), radius: 4, x: -1, y: -1)
    }
}

struct alertBoxComponent_Previews: PreviewProvider {
    static var previews: some View {
        alertBoxComponent(text: .constant(""))
    }
}
