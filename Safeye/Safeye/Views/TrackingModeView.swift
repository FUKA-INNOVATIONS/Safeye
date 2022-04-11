//
//  TrackingModeView.swift
//  Safeye
//
//  Created by dfallow on 10.4.2022.
//

import SwiftUI

struct TrackingModeView: View {
    
    @StateObject private var viewModel = EventViewModel()
    @State var panicMode: Bool = false
    
    var body: some View {
    
        VStack {
            
            Text("Current Status: \(viewModel.mode)")
                .font(.largeTitle)
                .padding(.top, 100)
            
            Spacer()
            viewModel.mode == "Tracking" ?
            Button(action: {
                viewModel.activatePanicMode()
                panicMode = true
                }) {
                    PanicButtonComponent(panicmode: $panicMode)
            }
            :
            Button(action: {
                viewModel.disableTrackingMode()
                panicMode = false
                }) {
                    PanicButtonComponent(panicmode: $panicMode)
                }
            //PanicButtonComponent()
            Spacer()
        
            //Send value of tracking: true to map view
            NavigationLink("View Map", destination: MapView())
                .padding()
                
            // Needs to be replace with button
            Text("Disable Tracking")
                .padding()
        
            Spacer()
            
        }.ignoresSafeArea()
        
    }
}

struct TrackingModeView_Previews: PreviewProvider {
    static var previews: some View {
        TrackingModeView()
.previewInterfaceOrientation(.portraitUpsideDown)
    }
}
