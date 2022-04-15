//
//  ConnectionRequestModel.swift
//  Safeye
//
//  Created by gintare on 10.4.2022.
//  Edited by FUKA

import Foundation
import FirebaseFirestoreSwift

struct ConnectionRequestModel: Identifiable, Codable {
    @DocumentID var id: String?
    var userId: String
    var fullName: String
}
