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
                    
                    Image("safeye")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, alignment: .center)
                        .padding()
                    
                    Text("**Safeye** is an app that will bring you the peace of mind when you or your loved ones go out and might end up in unsafe situations.\n\nWith the help of **Safeye**, you can let those closest to you know when you are heading out on a first date, a night at a bar or a dinner with friends and allow your contacts to keep an eye on you. **Safeye** allows them to see your location and you can alert your friends if you get into a dangerous situation.\n\n*Safeye is here to keep you safe!*")
                        .paragraphStyle(alignment: .center)
                }
                .padding()
                Spacer()
            } else if (self.section == "FAQ") {
                ScrollView {
                    Text("FAQ")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                    ForEach(FAQItem.items) { item in
                        HStack {
                            Image(item.icon)
                            Text(item.question)
                                .font(.system(size: 15))
                                .fontWeight(.bold)
                                .frame(width: 200)

                        }
                        .frame(alignment: .center)
                        
                        Text(item.answer)
                            .paragraphStyle()
                            .padding()
                    }
                }
            } else if (self.section == "privacy") {
                
                Text("Privacy")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                Text("Your privacy is important to us, therefore the users of Safeye have limited access to information about you. Bellow are the details about  information visibility.")
                    .paragraphStyle()
            
                List(PrivacyItem.items) { item in
                    HStack{
                        Text(item.sectionName)
                            .frame(width: 150, alignment: .leading)
                        Spacer()
                        Text(item.privacyGroup)
                            .foregroundColor(.gray)
                            .font(.system(size: 12).italic())
                            .multilineTextAlignment(.trailing)
                            .frame(alignment: .trailing)
                    }
                }
                .padding()
            } else if (self.section == "how") {
                
                Text("How it works")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
            
                ScrollView {
                ForEach(HowItWorksItem.items) { item in
                    HStack {
                        Spacer()
                        Image(item.icon)
                        Spacer()
                        Text(item.step)
                            .frame(width: 230, alignment: .leading)
Spacer()
                    }
                }
                .padding(.bottom)
  
                }
            }
            
        }
        
    }
}

struct HowItWorksItem: Identifiable {
    var id = UUID()
    var icon: String
    var step: String
}

extension HowItWorksItem {
    static let items = [
        HowItWorksItem(icon: "contact", step: "Make sure to add at least one contact on Safeye."),
        HowItWorksItem(icon: "event", step: "Create a new event: fill out the event details and select contacts."),
        HowItWorksItem(icon: "emergency", step: "In case of an emergency, tap SOS. Your location will be tracked and Safeye will record messages of anything it can detect in your surroundings."),
        HowItWorksItem(icon: "alert", step: "Your contacts will be alerted. They will be able to see your live location and read recorded messages."),
        HowItWorksItem(icon: "safe", step: "When you're safe again, tap SAFE to disable the emergency mode."),
        HowItWorksItem(icon: "delete", step: "Once your event is over and you're in a safe location, you can delete the event. This will also delete any information related to it."),

    ]
}

struct FAQItem: Identifiable {
    var id = UUID()
    var icon: String
    var question: String
    var answer: String
}

extension FAQItem {
    static let items = [
        FAQItem(icon: "contact", question: "Why do I need to have connections on Safeye and how to add one?", answer: "Your connections are people you trust the most. Once you add them as contacts in Safeye, they can be selected in your future events. That allows them to see your event information, your location during the  event and any recorded messages. In case of an emergency, Safeye alerts your contacts by letting them know that you need their help. Based on your location information and any recorded messages, your contacts can then decide what is the best way to help you.\n\nTo add a new contact, navigate to 'Connections' tab. Copy your personal 'connection code' and share it with your friends. They then can search for you on Safeye using your code and add you as a contact. Then all you need to do, is to confirm their request. Likewise, if someone has shared their connection code with you, you can just click on 'Add a new contact', search for your friend using the connection code and send them a request."),
    FAQItem(icon: "safe-space", question: "What is a safe space and how to add one?", answer: "A safe space is any location that you know you can go to in case of an emergency. It can be your mom's work address, a local library, a shop open 24/7 or any other location you that you can think of.\n\nTo add a new safe space, navigate to 'Profile' and click on 'Add new' in 'My safe spaces' section. Then type in the address and click 'Save'. In addition to adding safe spaces manually, your contact home addresses will be saved to your safe spaces automatically once you add them as a contact. You can always find your safe spaces in the 'Profile' tab by clicking 'View on map'."),
    FAQItem(icon: "event", question: "What are events and how to create one?", answer: "Events are Safeye's way of letting your contacts know you will be going out and will be needing them to keep a watchful eye on you.\n\nYou can create a new event in the 'Home' tab. Just fill out the event details and select those contacts that you want to have access to your event and location information while the event is active. Only those contacts that you select for the event will be sent an alert in case of an emergency. Likewise, those contacts that you do not select will not be able to see any information about the event or your location. Similarly, your contacts can add you to their events.\n\nTo delete an event, go to the 'Home' tab, find the event you want to delete and swipe left. This will also delete any information associated with the event, such as your event details, location information or any messages that were recorded."),
    FAQItem(icon: "emergency", question: "What is the emergency mode and how to enable/disable it?", answer: "Any situation in which you feel unsafe qualifies for an emergency. To activate the emergency mode, go to your event and click the big red 'SOS' button. This will activate location tracking, your contacts will be alerted and Safeye will start periodically recording any messages that it can hear from your surroundings. Your contacts can then see your location, read the recorded messages and based on that determine how best to help you.\n\nTo disable the emergency mode, just click the big green button 'Safe'. The event will still continue, but emergency mode will be disabled.\n\nIn case of grave danger, please call 112 or the local emergency number."),
    FAQItem(icon: "message", question: "What are recorded messages, how to add one and how are they used?", answer: "Recorded messages come in two types on Safeye. The first one is a message that you can record during your event. Just navigate to your event and click 'Record Message'. This will log whatever you are saying. Then just click 'Save/update your message' and it will be saved for your contacts to see.\n\nAnother type of messages are those that are recorded automatically. Once you activate the emergency mode, Safeye starts recording any speech that it can hear from you and your surroundings and save those messages for your contacts to read. It helps your friends and loved ones to determine what situation you are in and how best to help you. Once the event is deleted, all the messages are deleted as well."),
    FAQItem(icon: "health", question: "Why do you need my health information?", answer: "In case of a serious emergency, those contacts that you add to an event would be able to share that information with any emergency services. This could potentially benefit them in helping you.")
    ]
}

struct PrivacyItem: Identifiable {
    var id = UUID()
    var sectionName: String
    var privacyGroup: String
}

extension PrivacyItem {
    static let items = [
        PrivacyItem(sectionName: "Profile picture", privacyGroup: "Your contacts,\nother Safeye users"),
        PrivacyItem(sectionName: "Full name", privacyGroup: "Your contacts,\nother Safeye users"),
        PrivacyItem(sectionName: "Health details", privacyGroup: "Your contacts"),
        PrivacyItem(sectionName: "Home address", privacyGroup: "Your contacts"),
        PrivacyItem(sectionName: "Event details", privacyGroup: "Your event contacts"),
        PrivacyItem(sectionName: "Live location", privacyGroup: "Your event contacts"),
        PrivacyItem(sectionName: "Recorded messages", privacyGroup: "Your event contacts")
    ]
}

extension View {
    func paragraphStyle(alignment: TextAlignment = .leading) -> some View {
        modifier(InfoTextModifier(alignment: alignment))
    }
}

