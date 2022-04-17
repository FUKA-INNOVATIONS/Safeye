//
//  EventListView.swift
//  Safeye
//
//  Created by FUKA on 17.4.2022.
//

import SwiftUI

struct EventListView: View {
    //@State var event: Event
    
    var body: some View {
        VStack {
             Form {
                 Section(header: Text("Your events")) {
                         HStack {
                             Text("Fuad Kalhori")
                             Text("2.3.2022")
                             Spacer()
                             Image(systemName: "minus.circle.fill")
                             Image(systemName: "eye")
                         }
                         
                         HStack {
                             Text("Fuad Kalhori")
                             Text("2.3.2022")
                             Spacer()
                             Image(systemName: "minus.circle.fill")
                             Image(systemName: "eye")
                         }
                 }
                 
                 Section(header: Text("Your friend's events")) {
                     HStack {
                         Text("Fuad Kalhori")
                         Text("2.3.2022")
                         Spacer()
                         Image(systemName: "eye")
                     }
                     
                     HStack {
                         Text("Fuad Kalhori")
                         Text("2.3.2022")
                         Spacer()
                         Image(systemName: "eye")
                     }
                 }
            }
        }
    }
}

struct EventListView_Previews: PreviewProvider {
    static var previews: some View {
        EventListView()
    }
}
