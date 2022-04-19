//
//  SafePlaceService.swift
//  Safeye
//
//  Created by Ali Fahad on 16.4.2022.
//

import Foundation
import Foundation
import Firebase


class SafePlaceService {
    static let shared = SafePlaceService() ;  private init() {}
    private var placeDB = Firestore.firestore().collection("safePlaces")
    private let appStore = Store.shared
    
//extension FileManager {
//    static var documentsDirectory: URL {
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        return paths[0]
//    }
//}
}
