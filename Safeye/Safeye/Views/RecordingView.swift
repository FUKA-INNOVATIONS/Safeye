//
//  SwiftUIView.swift
//  Safeye
//
//  Created by dfallow on 22.4.2022.
//

import SwiftUI

struct RecordingView: View {
    @EnvironmentObject var EventVM: EventViewModel
    @EnvironmentObject var appState: Store
    @StateObject var voiceRecognizer = VoiceRecognizer()
    @State private var isRecording = false
    var translationManager = TranslationService.shared

    
    // Used to dismiss current sheet
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Spacer()
            
//            Text("Recording Your Message")
            Text(translationManager.recordedYourMessages)
                .font(.largeTitle)
            
            Spacer()
            
            Text("\(voiceRecognizer.userMessage)")
            
            Spacer()
            
            Button {
                
                // save current message to database
                appState.event!.userMessage.append(voiceRecognizer.userMessage)
                EventVM.updateEvent(appState.event!)
                
                voiceRecognizer.stopTranscribing()
                isRecording = false
                
                // Closes the sheet
                self.presentationMode.wrappedValue.dismiss()
                
//            } label: { Text("Save/Update Your Message") }
            } label: { Text(translationManager.SaveUpdateBtn) }
            
            Spacer()
            
            // Cancels current recording of message, does not update in database
            Button {
                voiceRecognizer.stopTranscribing()
                isRecording = false
//                self.presentationMode.wrappedValue.dismiss() } label: { Text("Cancel Recording")}
                self.presentationMode.wrappedValue.dismiss() } label: { Text(translationManager.cancelRecording)}

            
        }
        .onAppear {
            voiceRecognizer.reset()
            voiceRecognizer.transcribe()
            isRecording = true
        }
        .onDisappear {
            voiceRecognizer.stopTranscribing()
            isRecording = false
        }
    }
        
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        SwiftUIView()
//    }
//}
