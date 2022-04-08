//
//  ProfileService.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//  EDited by FUKA 8.4.2022.


import Foundation
import Firebase // Import firebase


// TODO: Database is in test mode, set rules and change to production mode

class ProfileService {
    static let getInstance = Firestore.firestore() // Get instance of Firestore database
}
