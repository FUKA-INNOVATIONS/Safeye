//
//  CreateEventView.swift
//  Safeye
//
//  Created by gintare on 8.4.2022.
//  Edited by FUKA 11.4.2022

import SwiftUI

struct CreateEventView: View {
    @EnvironmentObject var EventVM: EventViewModel
    @EnvironmentObject var ConnectionVM: ConnectionViewModel
    @EnvironmentObject var appState: Store
    
    @State var authUID = AuthenticationService.getInstance.currentUser?.uid
    @State var startDate = Date()
    @State var endDate = Date()
    @State var eventType = ""
    //@State var locationDetails: String = ""
    @State var otherInfo: String = ""
    @State var eventFolderPath = ""
    
    let eventTypesArray = ["bar night", "night club", "dinner", "house party", "first date", "other"]
    @State private var cityOfEvent = ""
    
    @State var goEventView = false
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        VStack{
            Form {
                Section(header: Text("Select contacts for the event*"), footer: Text("These contacts will be able to see event details")) {
                    SelectContactGridComponent()
                }
                
                ForEach(appState.eventSelctedContacts) { selectedContact in
                    HStack {
                        Text("\(selectedContact.fullName)")
                        Spacer()
                        Image(systemName: "person.fill.checkmark")
                    }
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
                    .pickerStyle(.inline)
                }
                
                
                Section(header: Text("Location")) {
                    Picker(selection: $cityOfEvent, label: Text("Select a city or area")) {
                        ForEach(appState.citiesFinland, id: \.self) {
                            Text($0).tag($0)
                        }
                    }
                    .pickerStyle(.wheel)
                }
                
                
                Section(header: Text("Other valuable details")) {
                    TextField("Anything else?", text: $otherInfo)
                }
                
            }.navigationBarTitle("Add event information", displayMode: .inline)
            Spacer()
            
            
            
            BasicButtonComponent(label: "Save & activate", action: {
                if eventType.isEmpty || cityOfEvent.isEmpty { print("Fill all fields") ; return }
                
                // set a random path for event folder and pass it to EventVM to createEvent()
                eventFolderPath = "events/\(UUID().uuidString)/"
                if EventVM.createEvent(startDate, endDate, otherInfo, eventType, cityOfEvent, eventFolderPath) {
                    //goEventView.toggle()
                    //NavigationLink("", destination: EventView(), isActive: $goEventView)
                    dismiss()
                }
            })
            
            //let id = "qGcGgDF8K3FvJjplNYP4"
            //let updatedEvent = Event(id: id, ownerId: authUID ?? "", status: EventStatus.STARTED, startTime: startDate, endTime: endDate, otherInfo: locationDetails, eventType: eventType, trustedContacts: selectedContacts, coordinates: coordinates)
            // BasicButtonComponent(label: "Save & activate", action: { EventVM.updateEvent( updatedEvent ) })
            
            Text("Saving will also enable the tracking mode")
                .font(.system(size: 15))
                .foregroundColor(.blue)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .onAppear {
            EventVM.resetEventSelectedContacts()
            ConnectionVM.getConnections()
            ConnectionVM.getConnectionProfiles()
        }
        
    }
    
}

struct CreateEventView_Previews: PreviewProvider {
    static var previews: some View {
        CreateEventView()
    }
}
