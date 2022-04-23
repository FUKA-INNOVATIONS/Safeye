//
//  SafePlaceModel.swift
//  Safeye
//
//  Created by FUKA on 14.4.2022.
//

import Foundation
import FirebaseFirestoreSwift

struct SafePlaceModel: Codable, Identifiable {
    @DocumentID var id: String?
    var ownerId: String
    var name: String
    var longitude: Double
    var latitude: Double
}
