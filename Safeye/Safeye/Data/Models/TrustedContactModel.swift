//
//  TrustedContactModel.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//  Edit by gintare 24.4.2022.

import SwiftUI
import FirebaseFirestoreSwift


struct TrustedContactModel: Identifiable {
    @DocumentID var id: String?
    var userId: String
    var fullName: String
    var avatarPhoto: UIImage?
}
