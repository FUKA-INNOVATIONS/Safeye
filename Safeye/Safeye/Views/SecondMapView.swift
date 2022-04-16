//
//  MapView.swift
//  maptest
//
//  Created by Ali Fahad on 10.4.2022.
//

import SwiftUI
import MapKit

struct SecondMapView: UIViewRepresentable {
    
    @EnvironmentObject var mapData : AddSafePlaceViewModel

    func makeCoordinator() -> Coordinator {
        return SecondMapView.Coordinator()
    }

    func makeUIView(context: Context) -> MKMapView {
        
        let view = mapData.mapView
        
        view.showsUserLocation = true
        view.delegate = context.coordinator
        
        return view
    
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
    class Coordinator: NSObject, MKMapViewDelegate{
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            
            // custom pin....
            
            if annotation.isKind(of: MKUserLocation.self ){return nil}
            else{
                let pinAnnotation = MKPinAnnotationView(annotation: annotation,
                    reuseIdentifier: "PIN_VIEW")
                pinAnnotation.tintColor = .red
                pinAnnotation.animatesDrop = true
                pinAnnotation.canShowCallout = true
                
                return pinAnnotation
            }
        }
    
    }
}
