//
//  SearchResultModel.swift
//  Safeye
//
//  Created by Pavlo Leinonen on 22.4.2022.
//

import Foundation
import MapKit
import Combine

class SearchResultModel: ObservableObject {
    
    @Published var searchText: String = ""
    @Published var places = [SafeSpaceModel]()
    @Published var locations = [MKMapItem]()
    var cancellable: AnyCancellable?

    init() {
        cancellable = $searchText.debounce(for: .seconds(0.25), scheduler: DispatchQueue.main)
            .sink { value in
                if !value.isEmpty && value.count > 3 {
                    self.search(text: value, region: LocationService.shared.region)
                } else {
                    self.places = []
                }
            }
    }
    
    func search(text: String, region: MKCoordinateRegion) {
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = text
        searchRequest.region = region
        
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { response, error in
            
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            self.places = response.mapItems.map(SafeSpaceModel.init)
            
            self.locations = response.mapItems
            print("map-map \(type(of: response.mapItems))")
        }
    }
    
    
}
