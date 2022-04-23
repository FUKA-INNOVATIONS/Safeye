//
//  SwiftUIView.swift
//  Safeye
//
//  Created by dfallow on 22.4.2022.
//

import SwiftUI

struct RecordingView: View {
    
    @StateObject var voiceRecognizer = VoiceRecognizer()
    @State private var isRecording = false
    
    // Used to dismiss current sheet
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Recording Your Message")
                .font(.largeTitle)
            
            Spacer()
            
            Text("\(voiceRecognizer.userMessage)")
            
            Spacer()
            
            Button {
                
                // TODO Act functionality to save current message to database
                
                voiceRecognizer.stopTranscribing()
                isRecording = false
                
                // Closes the sheet
                self.presentationMode.wrappedValue.dismiss()
                
            } label: { Text("Save/Update Your Message") }
            
            Spacer()
            
            // Cancels current recording of message, does not update in database
            Button {
                voiceRecognizer.stopTranscribing()
                isRecording = false
                self.presentationMode.wrappedValue.dismiss() } label: { Text("Cancel Recording")}
            
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
