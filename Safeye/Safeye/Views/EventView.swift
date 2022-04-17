//
//  TrackingModeView.swift
//  Safeye
//
//  Created by dfallow on 10.4.2022.
//

import SwiftUI

struct EventView: View {
    
    @StateObject private var viewModel = EventViewModel.shared
    @State var panicMode: Bool = false
    @State private var isPresented: Bool = false
    @State private var text: String = ""
    @State private var items = (1...5).map { _ in "($0)" }
    
    var body: some View {
        
        ZStack(alignment: .center) {
            VStack {
                
                Text("Current Status: \(viewModel.mode)")
                    .font(.largeTitle)
                
                Spacer()
                viewModel.mode == "Tracking" ?
                // User is currently in tracking mode, presses panic button for help
                Button(action: {
                    // Actions after panic button Has been pressed
                    self.isPresented = true
                    
                    viewModel.activatePanicMode()
                    panicMode = true
                    viewModel.sentNotification()
                }) {
                    TrackingModeButtonComponent(panicmode: $panicMode)
                }
                :
                
                // User is in panic mode presses are you safe button
                Button(action: {
                    viewModel.disablePanicMode()
                    panicMode = false
                }){
                    TrackingModeButtonComponent(panicmode: $panicMode)
                }
                //PanicButtonComponent()
                Spacer()
                
                //Send value of tracking: true to map view
                NavigationLink("View Map", destination: MapView())
                    .padding()
                
                // Replace with button?
                NavigationLink("Disable Tracking", destination: ContentView())
                    .disabled(true)
                
                Spacer()
                
            }
            alertBoxComponent(buttonIsPressed: $isPresented,text: $text)
        }
        
        .navigationBarHidden(true)
        
    }
}

struct TrackingModeView_Previews: PreviewProvider {
    static var previews: some View {
        EventView()
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
