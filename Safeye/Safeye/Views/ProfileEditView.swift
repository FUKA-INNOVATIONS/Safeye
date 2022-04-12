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
    
    /* init() {
     print("ProfileEditView init")
     profileViewModel.getProfile()
     } */
    
    
    var body: some View {
        
        // Profile exists and user has all profile details, prefell all fields
        if ProfileVM.profileExists {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                self.fullName = ProfileVM.profileDetails!.fullName
                self.address = ProfileVM.profileDetails!.address
                self.birthday = ProfileVM.profileDetails!.birthday
                self.bloodType = ProfileVM.profileDetails!.bloodType
                self.illness = ProfileVM.profileDetails!.illness
                self.allergies = ProfileVM.profileDetails!.allergies
            }
            
        }
        
        return VStack() {
            if ProfileVM.profileExists {
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
                
                if !ProfileVM.profileExists { // User has no profile, create new one
                    print("User has no PROFILE, add new profile")
                    
                    // User has filled all form fields
                    if fullName.count < 1 || address.count < 1 || birthday.count < 1 || bloodType.count < 1 || illness.count < 1 || allergies.count < 1 {
                        self.showEmptyFieldAlert = true // Show alert box
                        return
                    }
                    
                    // Hash the code needed to search for the user
                    var hasher = Hasher()
                    hasher.combine(AuthVM.authService.currentUser!.uid)
                    let connectionHash = String(hasher.finalize())
                    
                    // Insert profile data into the database
                    ProfileVM.addDetails(fullName: fullName, address: address, birthday: birthday, bloodType: bloodType, illness: illness, allergies: allergies, connectionCode: connectionHash)
                    
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
                    ProfileVM.upateDetails(fullName: fullName, address: address, birthday: birthday, bloodType: bloodType, illness: illness, allergies: allergies)
                    
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
