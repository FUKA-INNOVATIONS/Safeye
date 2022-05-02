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
    var translationManager = TranslationService.shared

    
    @EnvironmentObject var mapVM: MapViewModel
    
    var body: some View {
        HStack {
            Text(trustedContact.fullName)
            Spacer()

            if trustedContact.homeLatitude != nil {
                Button(action: {
                    mapVM.mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: trustedContact.homeLatitude!, longitude: trustedContact.homeLongitude!), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                            }, label: {Text(translationManager.focusBtn)})
                    .border(Color.blue, width: 2)
                    .padding()
                    .foregroundColor(Color.white)
                    .background(Color.blue)
            } else {
                Text("No home set")
                    .foregroundColor(Color.gray)
            }
            
            
        }
        .modifier(TCItemModifier())
    }
}

struct CurtainTCComponent_Previews: PreviewProvider {
    static var previews: some View {
        CurtainTCComponent(trustedContact: ProfileModel(id: "", userId: "", fullName: "David Fallow", address: "", birthday: "", bloodType: "", illness: "", allergies: "", connectionCode: "", avatar: ""))
    }
}
