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
        print("Panic Mode")
        mode = "Panic"
    }
    
    // User pressed the safe button -> disabling panic mode
    func disableTrackingMode() {
        print("Disabled")
        mode = "Tracking"
    }
    
    
}
