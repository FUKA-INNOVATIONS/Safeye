//
//  SafeSpaceModel.swift
//  Safeye
//
//  Created by Pavlo Leinonen on 22.4.2022.
//

import Foundation
import MapKit

struct SafeSpaceModel: Identifiable, Hashable {
    
    let id = UUID()
    var mapItem: MKMapItem
    
    init(mapItem: MKMapItem) {
        self.mapItem = mapItem
    }
    
    var name: String {
        mapItem.name ?? ""
    }
    
}
