//
//  CurtainTCComponent.swift
//  Safeye
//
//  Created by dfallow on 9.4.2022.
//

import SwiftUI
import MapKit

struct CurtainTCComponent: View {
    var trustedContact: ProfileModel
    
    @EnvironmentObject var mapVM: MapViewModel
    
    var body: some View {
        HStack {
            Text(trustedContact.fullName)
            Spacer()
            
            if trustedContact.homeLatitude != nil {
                Button(action: {
                    mapVM.mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: trustedContact.homeLatitude!, longitude: trustedContact.homeLongitude!), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                            }, label: {Text("Focus on home")})
            } else {
                Text("No home set")
                    .foregroundColor(Color.gray)
            }
            
            
        }
        .modifier(TCItemModifier())
    }
}

//struct CurtainTCComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        CurtainTCComponent()
//    }
//}
