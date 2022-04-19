//
//  EventModel.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//  Edit by FUKA on 11.4

import Foundation

import FirebaseFirestoreSwift

struct Event: Codable, Identifiable {
    @DocumentID var id: String?
    var ownerId: String
    var status: EventStatus
    var startTime: Date
    var endTime: Date
    var otherInfo: String
    var eventType: String
    var trustedContacts: [String]
    var audioFiles: [URL]?
    var coordinates: [String : Double]
    var eventFolderPath: String
    //var isOwner = false // TODO: check for ownership before adding to state
}
