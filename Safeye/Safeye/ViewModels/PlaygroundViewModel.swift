//
//  PlaygroundViewModel.swift
//  Safeye
//
//  Created by FUKA on 14.4.2022.
//

import Foundation

class PlaygroundViewModel: ObservableObject {
    static let shared = PlaygroundViewModel() ; private init() {}
    private let appstate = Store.shared
    private let connService = ConnectionService.shared
    
    func changeText(_ newText: String) {
        //self.appstate.sayHello(newText)
    }
    
    func fetchConn() {
        self.connService.fetchPendingConnectionRequests()
    }
    
}
