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
    
    var translationManager = TranslationService.shared
    
    @State var authUID = AuthenticationService.getInstance.currentUser?.uid
    @State var startDate = Date()
    @State var endDate = Date()
    @State var eventType = ""
    //@State var locationDetails: String = ""
    @State var otherInfo: String = ""
    
    let eventTypesArray = ["bar night", "night club", "dinner", "house party", "first date", "other"]
    
    @State var goEventView = false
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        VStack{
            Form {
                Section(header: Text(translationManager.selectContactsTitle), footer: Text(translationManager.createEventInfoText)) {
                    SelectContactGridComponent()
                }
                
                ForEach(appState.eventSelctedContacts) { selectedContact in
                    HStack {
                        Text("\(selectedContact.fullName)")
                        Spacer()
                        Image(systemName: "person.fill.checkmark")
                    }
                }
                
                Section(header: Text(translationManager.dateAndTime)) {
                    DatePicker(translationManager.startTime, selection: $startDate)
                    DatePicker(translationManager.endTime, selection: $endDate)
                }
                Section(header: Text(translationManager.eventType)) {
                    Picker(selection: $eventType, label: Text(translationManager.selectEventType)) {
                        ForEach(eventTypesArray, id: \.self) {
                            Text($0).tag($0)
                        }
                    }
                    .pickerStyle(.inline)
                }
                /*Section(header: Text("Location*")) {
                    TextField("Describe location plan for the event", text: $locationDetails)
                }*/
                Section(header: Text(translationManager.otherDetailTitle)) {
                    TextField(translationManager.detailPlaceholder, text: $otherInfo)
                }
                
            }.navigationBarTitle(translationManager.addEventInfo, displayMode: .inline)
            Spacer()
            
            
            
            BasicButtonComponent(label: translationManager.saveActivateBtn, action: {
                if eventType.isEmpty { print("You must select event type") ; return }
                if EventVM.createEvent(startDate, endDate, otherInfo: otherInfo, eventType: eventType) {
                    //goEventView.toggle()
                    //NavigationLink("", destination: EventView(), isActive: $goEventView)
                    dismiss()
                }
            })
            
            //let id = "qGcGgDF8K3FvJjplNYP4"
            //let updatedEvent = Event(id: id, ownerId: authUID ?? "", status: EventStatus.STARTED, startTime: startDate, endTime: endDate, otherInfo: locationDetails, eventType: eventType, trustedContacts: selectedContacts, coordinates: coordinates)
            // BasicButtonComponent(label: "Save & activate", action: { EventVM.updateEvent( updatedEvent ) })
            
            Text(translationManager.savingEventInfo)
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
