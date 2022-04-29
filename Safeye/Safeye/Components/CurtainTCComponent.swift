//
//  CurtainTCComponent.swift
//  Safeye
//
//  Created by dfallow on 9.4.2022.
//

import SwiftUI
import MapKit

struct CurtainTCComponent: View {
    
    @EnvironmentObject var mapVM: MapViewModel
    var trustedContact: ProfileModel
    
    var body: some View {
        HStack {
            AvatarComponent(size: 50)
            Spacer()
            Text(trustedContact.fullName)
            Spacer()
            if trustedContact.homeLatitude != nil {
                Button(action: {
                    mapVM.mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: trustedContact.homeLatitude!, longitude: trustedContact.homeLongitude!), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                }, label: {Text("Focus on")})
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
