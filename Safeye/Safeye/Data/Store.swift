//
//  appState.swift
//  Safeye
//
//  Created by FUKA on 14.4.2022.
//

import Foundation
import SwiftUI

class Store: ObservableObject {
    static let shared = Store() ; private init() {}
    
    @Published var profile: ProfileModel?
    @Published var pendingRequests = [ConnectionModel]()
    @Published var trustedContacts = [ProfileModel]()
    @Published var safePlaces = [SafePlaceModel]()
    @Published var settings = [SettingModel]()
    @Published var events = [Event]()
    @Published var event: Event?

}



/*extension Store {
    func sayHello(_ newText: String) { self.greeting = "Hello from extention" }
}

extension Store {
    func getPengindgRequests() {}
} */
