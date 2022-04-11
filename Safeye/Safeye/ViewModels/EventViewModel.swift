//
//  EventViewModel.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//
// This viewModel is used for the TrackingModeView, it handles both tracking mode
// and panic mode for the user

import Foundation
import SwiftUI


class EventViewModel: ObservableObject {
    
    @Published var mode = "Tracking"
    
    // User presses panic mode
    func activatePanicMode() {
        print("Panic Mode activated")
        mode = "Panic"
        
        // TODO Panic Mode functionality #41 -> activate panic mode
    }
    
    // User pressed the safe button -> disabling panic mode
    func disablePanicMode() {
        print("Disabled panic mode")
        mode = "Tracking"
        
        // TODO Panic Mode functionality #41 -> disable panic mode
    }

    
    
}
