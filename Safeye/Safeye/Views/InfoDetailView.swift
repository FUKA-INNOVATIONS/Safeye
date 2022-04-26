//
//  InfoDetailView.swift
//  Safeye
//
//  Created by gintare on 25.4.2022.
//

import SwiftUI

struct InfoDetailView : View {
    @Binding var section: String?
    
    var body: some View {
        VStack {
            if (self.section == "about") {
                VStack {
                    Text("About Safeye")
                        .fontWeight(.bold)
                        .padding()
                    
                    Text("Safeye is an app that is intended to be used for your and your friends' safety. On Safeye you can create tracked events when you're going out, add selected individuals to those events and, once you have activate emergency mode, they will be alerted and will be able to see your location, listen to your surroundings and based on that information, they'll determine how best to help you.")
                }
                .padding()
                Spacer()
            } else if (self.section == "concepts") {
                ScrollView {
                    Text("Concepts explained")
                        .fontWeight(.bold)
                        .padding()
                    Section("Trusted contact") {
                        Text("Your trusted contacts are your friends, family or any other people you trust the most. After you've added a trusted contact to your connections, you will be able to also select them for your tracked events that you create. During those events, your selected trusted contacts will be able to see your location, get alerted when you activate emergency mode and listen to your surroundings. This will help them determine what is the best way to help you.")
                            .padding()
                    }
                    Divider()
                    Section("Events") {
                        Text("When you create a tracked event, you have to fill out the details about your event and select at least one trusted contact that will watch over you. Selected trusted contact(s) will be able to see the details about the event and see your location while the event is active.")
                            .padding()
                        Text("Your trusted contacts can likewise add you to their tracked events.")
                            .padding()
                    }
                }
                .padding()
                Spacer()
            } else if (self.section == "privacy") {
                ScrollView {
                    Text("Privacy")
                        .fontWeight(.bold)
                        .padding()
                    Section("Profile discovery") {
                        Text("Your profile can only be found with your personal connection code that you can share with the people you trust the most. You can find your connection code in the \"Connections\" tab. When someone searches for you by using your connection code, the only details that will be visible to them about you are you profile photo and your full name.")
                            .padding()
                    }
                    Divider()
                    Section("Personal details") {
                        Text("Your personal details, such as your name, address, health information, are only visible for your trusted contacts.")
                            .padding()
                    }
                    Divider()
                    Section("Event details") {
                        Text("Your tracked event details are only visible for those trusted contacts who you have selected for that particular event.")
                            .padding()
                    }
                    Divider()
                    Section("Location information") {
                        Text("Your live location is tracked during the tracked event. It is visible only for those trusted contacts who you have added to that particular event.")
                            .padding()
                        Text("Once you have activated the emergency mode, your location will be updated more frequently.")
                            .padding()
                    }
                    Divider()
                    Section("Voice recordings") {
                        Text("In emergency mode, the app will save short audio recordings of your surroundings. This is done, so that your trusted contacts, who are watching over you, can better understand what kind of situation you are in and how best to assist you.")
                            .padding()
                    }
                }
                .padding()
            }
            
        }
    }
    
}
