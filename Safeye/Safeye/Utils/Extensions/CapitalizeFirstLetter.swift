//
//  CapitalizeFirstLetter.swift
//  Safeye
//
//  Created by Koulu on 17.4.2022.
//

import Foundation


extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
