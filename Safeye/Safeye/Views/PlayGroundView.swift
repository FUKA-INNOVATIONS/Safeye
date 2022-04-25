//
//  PlayGroundView.swift
//  Safeye
//
//  Created by FUKA on 13.4.2022.
//

import SwiftUI

struct PlayGroundView: View {
    @EnvironmentObject var ConnectionVM: ConnectionViewModel
    @EnvironmentObject var PlaygroundVM: PlaygroundViewModel
    @EnvironmentObject var appState: Store
    @FetchRequest(sortDescriptors: []) var cities: FetchedResults<City>
    @Environment(\.managedObjectContext) var moc
    
    @EnvironmentObject var EventVM: EventViewModel
    
    
    
    var body: some View {
        
        return VStack {
            
            ForEach(self.appState.connectionPofiles) { profile in
                Text("Connection profile : \(profile.fullName)")
            }
            
            
            VStack {
                Text("cities in appState: : \(appState.citiesFinland.count)")
                Text("cities in device: : \(cities.count)")
                Button("save device") { saveDevice() }
                List(cities, id: \.id) { city in
                    HStack {
                        Text(city.name ?? "no city name")
                        Spacer()
                        //Button("delete") { moc.delete(city) ; try? moc.save() }
                    }
                }
            }
            
            
            Text("Hello playground")
            Text("Event: \(self.appState.event?.otherInfo ?? "No info" )")

            
        }
        .task {
            print("Map view ")
        }
        .onAppear {
            
//            self.ConnectionVM.getConnections()
//            self.ConnectionVM.getConnectionProfiles()
            print("Connections: \(appState.connections.count)")
            print("Profiles: \(appState.connectionPofiles.count)")
        }
        
    }
    
    
    func saveDevice() {
        // save all cities in device momeory
        for city in appState.citiesFinland {
            let c = City(context: moc)
            c.id = UUID()
            c.name = city
            c.country = "Finland"
        }
        
        // save all cities in device persistant storage if data has changed
        if moc.hasChanges {
            do {
                try moc.save()
                print("CoreData: Cities saved")
            } catch {
                print("CoreData: Error while saving citites into device \(error.localizedDescription)")
            }
        } else { print("CoreData: Cities not saved in device beause of no changes") }
        print("CoreData: : \(cities.count)")
    }
    
    
}

