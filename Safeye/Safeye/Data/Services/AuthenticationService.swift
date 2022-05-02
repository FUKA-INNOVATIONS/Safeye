//
//  AuthenticationService.swift
//  Safeye
//
//  Created by Safeye team on 1.4.2022.
//

/*
    This service handles authentication services related to the user using Firebase Authentication.
    It communicates with the database in order to handle the five functionalities present in the
    AuthenticationViewModel.
 */

import FirebaseAuth // Import Firebase Authentication

class AuthenticationService {
    static let getInstance = Auth.auth()
}
