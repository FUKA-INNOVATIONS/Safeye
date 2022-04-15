//
//  ProfileEditView.swift
//  Safeye
//
//  Created by FUKA on 8.4.2022.
//  Edit by gintare on 10.4.2022.

import SwiftUI

struct ProfileEditView: View {
    @EnvironmentObject var ProfileVM: ProfileViewModel
    @EnvironmentObject var AuthVM: AuthenticationViewModel
    @EnvironmentObject var appState: Store
    
    
    @State private var showEmptyFieldAlert = false
    
    @Environment(\.dismiss) var dismiss
    
    @State private var fullName = ""
    @State private var address = ""
    @State private var birthday = ""
    @State private var bloodType = ""
    @State private var illness = ""
    @State private var allergies = ""
    @State private var connectionCode = ""
    
    @State private var bloodTypes = ["A", "A+", "B"]
    
    
    var body: some View {
        
        // Profile exists and user has all profile details, prefell all fields
        if appState.profile != nil {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                self.fullName = self.appState.profile!.fullName
                self.address = self.appState.profile!.address
                self.birthday = self.appState.profile!.birthday
                self.bloodType = self.appState.profile!.bloodType
                self.illness = self.appState.profile!.illness
                self.allergies = self.appState.profile!.allergies
            }
        }
        
        return VStack() {
            if self.appState.profile != nil {
                Text("Please fill the fileds you want to update")
                
            } else {
                Text("Please fill all fields to create new profile")
            }
            
            HStack{
                InputFieldComponent(title: "Full name", inputText: $fullName)
            }
            
            HStack{
                InputFieldComponent(title: "Address", inputText: $address)
            }
            HStack{
                InputFieldComponent(title: "Birthday", inputText: $birthday)
            }
            HStack{
                VStack(alignment: .leading){
                    
                    // Select blood type
                    Section { // Sections can have header and footer
                        Picker("Tip percentage", selection: $bloodType) {
                            ForEach(bloodTypes, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.segmented)
                    } header: {
                        Text("Blood type")
                    }
                    
                    InputFieldComponent(title: "Illness", inputText: $illness)
                    InputFieldComponent(title: "Allergies", inputText: $allergies)
                }
            }
            
            
            BasicButtonComponent(label: "Save & go back") { // Button to save profile details
                print("Save profile details pressed")
                
                if self.appState.profile == nil { // User has no profile, create new one
                    print("User has no PROFILE, add new profile")
                    
                    // User has filled all form fields
                    if fullName.count < 1 || address.count < 1 || birthday.count < 1 || bloodType.count < 1 || illness.count < 1 || allergies.count < 1 {
                        self.showEmptyFieldAlert = true // Show alert box
                        return
                    }
                    
                    
                    // Insert new profile data into the database
                    ProfileVM.createProfile(fullName, address, birthday, bloodType, illness, allergies)
                    
                    // presentationMode.wrappedValue.dismiss() // Close modal and return to ContentView()
                    dismiss()
                    
                    
                } else { // User has profile, update existing
                    print("User has a profile, update it")
                    
                    // User has filled all form fields
                    if fullName.count < 1 || address.count < 1 || birthday.count < 1 || bloodType.count < 1 || illness.count < 1 || allergies.count < 1 {
                        self.showEmptyFieldAlert = true // Show alert box
                        return
                    }
                    
                    // Update profile data in the database
                    ProfileVM.updateProfile(fullName, address, birthday, bloodType, illness, allergies)
                    
                    // presentationMode.wrappedValue.dismiss() // Close modal and return to ProfileView
                    dismiss()
                }
            }
            .alert(isPresented: $showEmptyFieldAlert) { // Alert user about emptu fields
                Alert(
                    title: Text("Fill all fields"),
                    message: Text("Please fill all fields")
                )
            }
            
            
            
        }
        
        
    }
}

/* struct ProfileEditView_Previews: PreviewProvider {
 static var previews: some View {
 ProfileEditView()
 }
 } */
