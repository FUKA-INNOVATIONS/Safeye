//
//  CityService.swift
//  Safeye
//
//  Created by FUKA on 20.4.2022.
//

import Foundation
import SwiftUI

class CityService {
    static let shared = CityService() ; private init() {}
    private var appState = Store.shared
    
    //init() { DispatchQueue.main.asyncAfter(deadline: .now() + 1) { self.isFetching = true } }
    //@Published var isFetching = false
    
    
    
    // Fetch list of citites of desired country and save it in appState
    
    func fetchCities(of countryName: String) {
        let urlString = "https://countriesnow.space/api/v0.1/countries/cities"
        guard let url = URL(string: urlString) else { return }
        
        let body = ["country": countryName]
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = finalBody
        
        self.appState.citiesFinland.removeAll()
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                if let data = data {
                    
                    let result = try JSONDecoder().decode(CityTransformer.self, from: data)
                    DispatchQueue.main.async { self.appState.citiesFinland = result.data }
                } else {
                    print("No data")
                }
            } catch {
                print("Failed to reach endpoint \(error)")
            }
        }.resume()
    }
    
    
    
    
    
}
