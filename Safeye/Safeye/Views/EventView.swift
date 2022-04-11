//
//  TrackingModeView.swift
//  Safeye
//
//  Created by dfallow on 10.4.2022.
//

import SwiftUI

struct EventView: View {
    
    @StateObject private var viewModel = EventViewModel()
    @State var panicMode: Bool = false
    
    var body: some View {
    
        VStack {
            
            Text("Current Status: \(viewModel.mode)")
                .font(.largeTitle)
                .padding(.top, 100)
            
            Spacer()
            viewModel.mode == "Tracking" ?
            // User is currently in tracking mode, presses panic button for help
            Button(action: {
                // Actions after panic button Has been pressed
                
                viewModel.activatePanicMode()
                panicMode = true
                
                }) {
                    TrackingModeButtonComponent(panicmode: $panicMode)
            }
            :
            // User is in panic mode presses are you safe button
            Button(action: {
                
                viewModel.disablePanicMode()
                panicMode = false
                
                }) {
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
            
        }.ignoresSafeArea()
        
    }
}

struct TrackingModeView_Previews: PreviewProvider {
    static var previews: some View {
        EventView()
.previewInterfaceOrientation(.portraitUpsideDown)
    }
}
