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
    
    
    
    func saveCitiesInDevice(appState: Store) {
        // save all cities in device momeory
        for city in appState.citiesFinland {
            let c = City(context: container.viewContext)
            c.id = UUID()
            c.name = city
            c.country = "Finland"
        }
        
        // save all cities in device persistant storage if data has changed
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
                print("SafeyeController: Cities saved")
            } catch {
                print("SafeyeController: Error while saving citites into device \(error.localizedDescription)")
            }
        } else { print("SafeyeController: Cities not saved in device beause of no changes") }
        //print("CoreData: : \(cities.count)")
    }
    
    
}

