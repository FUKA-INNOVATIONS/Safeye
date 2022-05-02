//
//  CityViewModel.swift
//  Safeye
//
//  Created by Safeye team on 6.4.2022.


/*
        This class is communicating with cityservice that in turn fetches cieties of a desired country as json format, converts to swift type and saves cities in app state
        
 */


import Foundation

class CityViewModel: ObservableObject { // ** Works
    static let shared = CityViewModel() ; private init() {}
    private var cityService = CityService.shared
    
    func getCities(of countryName: String) { // fetch cities if desired (argument) country and save it in app state
        cityService.fetchCities(of: countryName)
    }
    
    
    
}
