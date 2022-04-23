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
    var fullName: String
    var avatarPhoto: UIImage?
}
