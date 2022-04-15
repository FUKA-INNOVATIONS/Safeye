//
//  ConnectionModel.swift
//  Safeye
//
//  Created by FUKA on 12.4.2022.
//

import Foundation
import FirebaseFirestoreSwift

struct ConnectionModel: Codable, Identifiable {
    @DocumentID var id: String?
    var connectionId: String
    var connectionUsers: [String : String]
    var status: Bool
}
