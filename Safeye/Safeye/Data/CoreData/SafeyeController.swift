//
//  SafeyeController.swift
//  Safeye
//
//  Created by FUKA on 20.4.2022.
//

import Foundation
import CoreData

class SafeyeController: ObservableObject {
    let container = NSPersistentContainer(name: "Safeye") // Persistant data container Model
    
    
    // TODO: wrap all link views in LazyView utility
    
    init() {
        // load device storage
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core data filed to load \(error.localizedDescription)")
                return
            }
            // compare old and new object (city.name is unique) // prevents duplicates, name propety is set as constaint in the Model
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}

