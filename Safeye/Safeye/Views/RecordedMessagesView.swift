//
//  RecordedMessagesView.swift
//  Safeye
//
//  Created by Safeye Team on 1.4.2022.
//

import SwiftUI

struct RecordedMessagesView: View {
    @EnvironmentObject var appState: Store
    
    // TODO: Distinguish panic/other messages
    
    var body: some View {
        Text("Recorded messages")
        
        Form {
            ForEach(appState.event!.userMessage, id: \.self) { message in
                Text("\(message)")
            }
        }
    }
}

struct RecordedMessagesView_Previews: PreviewProvider {
    static var previews: some View {
        RecordedMessagesView()
    }
}
