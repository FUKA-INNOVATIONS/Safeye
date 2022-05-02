//
//  RecordedMessagesView.swift
//  Safeye
//
//  Created by FUKA on 25.4.2022.
//

import SwiftUI

struct RecordedMessagesView: View {
    @EnvironmentObject var appState: Store
    var translationManager = TranslationService.shared
    // TODO: Distinguish panic/other messages
    
    var body: some View {
//        Text("Recorded messages")
        Text(translationManager.recordedMessages)
        
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
