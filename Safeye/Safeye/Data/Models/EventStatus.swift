//
//  EventStatus.swift
//  Safeye
//
//  Created by FUKA on 11.4.2022.
//

import CoreText

enum EventStatus: String, CaseIterable, Codable {
    case STARTED = "Started",
         PAUSED = "Paused",
         PANIC = "Panic"
}
