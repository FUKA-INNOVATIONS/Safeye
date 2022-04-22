//
//  CityTransformerModel.swift
//  Safeye
//
//  Created by FUKA on 20.4.2022.
//

import Foundation


struct CityTransformer: Codable {
    var error: Bool
    var msg: String
    var data: [String]
    
    /*enum CodingKeys: String, CodingKey {
        case name = ""
    }*/
}
