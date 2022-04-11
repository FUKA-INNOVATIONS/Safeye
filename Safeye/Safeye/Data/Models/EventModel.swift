//
//  EventModel.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//  Edit by FUKA on 11.4

import Foundation


struct Event: Identifiable {
    var id: String?
    var ownerId: String
    var status: EventStatus
    var startTime: Date
    var endTime: Date
    var otherInfo: String
    var trustedContacts: [String]
    var audioFiles: [URL]?
    var coordinates: [String : Double]?
    
    
    
}
