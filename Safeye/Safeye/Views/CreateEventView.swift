//
//  CreateEventView.swift
//  Safeye
//
//  Created by gintare on 8.4.2022.
//

import SwiftUI

struct CreateEventView: View {
    @State var date: String = ""
    @State var type: String = ""
    @State var locationDetails: String = ""
    @State var otherInfo: String = ""
    
    
    
    var body: some View {
        ScrollView(.vertical){
            Spacer()
            Group {
                Text("Trusted contacts").font(.system(size: 20, weight: .bold))
                Text("Select trusted contacts for the event")
                SelectContactGridComponent()
            }
            Spacer(minLength: 20)
            Group {
                Text("Event details").font(.system(size: 20, weight: .bold))
                Text("These details will be visible for the selected contacts").font(.system(size: 15))
            }
            Spacer(minLength: 20)
            Group {
                InputFieldComponent(title: "When is the event taking place?", inputText: $date).border(.gray)
                InputFieldComponent(title: "What type of event is it?", inputText: $type).border(.gray)
                InputFieldComponent(title: "Where is the event taking place?", inputText: $locationDetails).border(.gray)
                InputFieldComponent(title: "Additional information", inputText: $otherInfo).border(.gray)
            }
            Text("By pressing 'Save', your event details will be saved and tracking mode will be enabled immediatly.")
            BasicButtonComponent(label: "Save", action: { print("Activated")})
        }
        
    }
    
}

struct CreateEventView_Previews: PreviewProvider {
    static var previews: some View {
        CreateEventView()
    }
}
