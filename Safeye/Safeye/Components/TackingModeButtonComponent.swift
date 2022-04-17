//
 //  PanicButtonComponent.swift
 //  Safeye
 //
 //  Created by Pavlo Leinonen on 7.4.2022.
 //

import SwiftUI

struct TrackingModeButtonComponent: View {
    @EnvironmentObject var appState: Store
    
    //var panicmode: Bool
    
     var body: some View {
         
         appState.event!.status == .PANIC ?
            Text("Are you Safe?")
             .foregroundColor(Color.white)
             .frame(width: 150, height: 150)
             .font(.system(size: 35))
             .background(Color.green)
             .clipShape(Circle())
         
         :
            Text("Panic")
             .foregroundColor(Color.black)
             .frame(width: 250, height: 250)
             .font(.system(size: 55))
             .background(Color.red)
             .clipShape(Circle())
         }
        
 }


//struct PanicButtonComponent_Previews: PreviewProvider {
//    static var previews: some View {
//        PanicButtonComponent()
//    }
//}
