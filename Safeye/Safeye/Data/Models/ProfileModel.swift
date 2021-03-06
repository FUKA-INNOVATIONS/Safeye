//
//  ProfileModel.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//  Edited by FUKa 8.4.2022.
//  Edited by gintare 10.4.2022.
// Edited by FUKA 13.4


import Foundation
import FirebaseFirestoreSwift

struct ProfileModel: Identifiable, Hashable, Codable {
    @DocumentID var id: String?
    var userId: String
    var fullName: String
    var address: String
    var birthday: String
    var bloodType: String
    var illness: String     // TODO: change to [String]
    var allergies: String   // TODO: change to [String]
    var connectionCode: String
    var avatar: String
    var homeLatitude: Double?
    var homeLongitude: Double?
}
