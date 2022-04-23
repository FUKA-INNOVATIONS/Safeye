//
//  TrustedContactModel.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//  Edit by gintare 10.4.2022.

import SwiftUI
import FirebaseFirestoreSwift

struct TrustedContactModel: Identifiable {
    @DocumentID var id: String?
    var userId: String
    var fullName: String
    var address: String
    var birthday: String
    var bloodType: String
    var illness: String
    var allergies: String
    var connectionCode: String
    var avatar: String
    var avatarPhoto: UIImage?
}
