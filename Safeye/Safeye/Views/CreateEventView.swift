//
//  CreateEventView.swift
//  Safeye
//
//  Created by gintare on 8.4.2022.
//  Edited by FUKA 11.4.2022

import SwiftUI

struct CreateEventView: View {
    @State var startDate = Date()
    @State var endDate = Date()
    @State var eventType = ""
    @State var locationDetails: String = ""
    @State var otherInfo: String = ""
    @State var selectedContacts: Array = ["Contact 1", "Contact 2"]
    @State var coordinates: [String : Double] = ["longitude": Double(12334324), "latitude": Double(454545)]
    
    let eventTypesArray = ["bar night", "night club", "dinner", "house party", "first date", "other"]
    
    @ObservedObject var EventVM = EventViewModel()
    @State var authUID = AuthenticationService.getInstance.currentUser!.uid
    
    var body: some View {
        VStack{
            Form {
                Section(header: Text("Select contacts for the event*"), footer: Text("These contacts will be able to see event details")) {
                    SelectContactGridComponent()
                }
                Section(header: Text("Estimated event date and time")) {
                    DatePicker("Start*", selection: $startDate)
                    DatePicker("End", selection: $endDate)
                }
                Section(header: Text("Event type*")) {
                    Picker(selection: $eventType, label: Text("Select event type")) {
                        ForEach(eventTypesArray, id: \.self) {
                            Text($0).tag($0)
                        }
                    }
                }
                Section(header: Text("Location*")) {
                    TextField("Describe location plan for the event", text: $locationDetails)
                }
                Section(header: Text("Other valuable details")) {
                    TextField("Anything else?", text: $otherInfo)
                }
                
            }.navigationBarTitle("Add event information", displayMode: .inline)
            Spacer()
            
            let newEvent = Event(ownerId: authUID, status: EventStatus.STARTED, startTime: startDate, endTime: endDate, otherInfo: otherInfo, eventType: eventType, trustedContacts: selectedContacts, coordinates: coordinates)
            BasicButtonComponent(label: "Save & activate", action: { EventVM.createEvent( newEvent: newEvent ) })
            Text("Saving will also enable the tracking mode")
                .font(.system(size: 15))
                .foregroundColor(.blue)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        
    }
    
}

struct CreateEventView_Previews: PreviewProvider {
    static var previews: some View {
        CreateEventView()
    }
}
