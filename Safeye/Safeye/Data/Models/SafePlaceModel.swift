//
//  SafePlaceModel.swift
//  Safeye
//
//  Created by FUKA on 14.4.2022.
//

import Foundation
import FirebaseFirestoreSwift
import MapKit
import SwiftUI

struct SafePlaceModel : Identifiable {
   @DocumentID var id: String?
    var place: CLPlacemark
    
}
