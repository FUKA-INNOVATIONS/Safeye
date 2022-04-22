//
//  CityViewModel.swift
//  Safeye
//
//  Created by FUKA on 20.4.2022.
//

import Foundation

class CityViewModel: ObservableObject { // ** Works
    static let shared = CityViewModel() ; private init() {}
    private var cityService = CityService.shared
    
    //init() { DispatchQueue.main.asyncAfter(deadline: .now() + 1) { self.isFetching = true } }
    //@Published var isFetching = false
    
    
    func getCities(of countryName: String) {
        cityService.fetchCities(of: countryName)
    }
    
    
    
}
