//
//  alertBoxComponent.swift
//  Safeye
//
//  Created by Pavlo Leinonen on 15.4.2022.
//
import UIKit
import SwiftUI

struct alertBoxComponent: View {
    
    @StateObject private var viewModel = EventViewModel.shared
    
    @EnvironmentObject var appState: Store
    @Binding var buttonIsPressed: Bool
    @Binding var text:String
    @Binding var panicMode: Bool
    
    var title: String = "Please confirm"
    let screenSize = UIScreen.main.bounds
    
    var onComfirm: (Void) -> Void = { _ in }
    var onCancel: () -> Void = { }
    
    var body: some View {
        VStack {
            Text(title)
            Spacer()
            HStack {
                Button("Confirm") {
                    buttonIsPressed = false
                    self.onComfirm(viewModel.activatePanicMode())
                    panicMode = true
                }
                
                Spacer()
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
        .offset(y: buttonIsPressed ? 0 : screenSize.height)
        .animation(.spring(response: 1, dampingFraction: 0.9))
        .shadow(color: Color(red: 0, green: 0, blue: 0), radius: 4, x: -1, y: -1)
    }
}

struct alertBoxComponent_Previews: PreviewProvider {
    static var previews: some View {
        alertBoxComponent(buttonIsPressed: .constant(true),text: .constant(""), panicMode: .constant(false))
    }
}
