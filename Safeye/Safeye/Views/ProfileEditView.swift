//
//  ProfileEditView.swift
//  Safeye
//
//  Created by FUKA on 8.4.2022.
//

import SwiftUI

struct ProfileEditView: View {
    @ObservedObject var profileViewModel = ProfileViewModel()
    @State private var showEmptyFieldAlert = false
    @Environment(\.presentationMode) var presentationMode // To close Modal view
    
    @State var fullName = ""
    @State var address = ""
    @State var birthday = ""
    @State var bloodType = ""
    @State var illness = ""
    @State var allergies = ""
    
    // self.fullName = self.profileViewModel.profileDetails?.fullName
    
    private var bloodTypes = ["A", "A+", "B"]
    
    init() {
        print("ProfileEditView init")
        profileViewModel.getProfile()
    }
    
    var body: some View {
        
        VStack() {
            
            if profileViewModel.profileExists {
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
            
            BasicButtonComponent(label: "Save details go back") { // Button saves profile details
                print("Save profile details pressed")
                
                if !profileViewModel.profileExists { // User has no profile, create new one
                    print("User has no PROFILE, add new profile")
                    
                    // User has filled all form fields
                    if fullName.count < 1 || address.count < 1 || birthday.count < 1 || bloodType.count < 1 || illness.count < 1 || allergies.count < 1 {
                        self.showEmptyFieldAlert = true // Show alert box
                        return
                    }
                    
                    
                    profileViewModel.addDetails(fullName: fullName, address: address, birthday: birthday, bloodType: bloodType, illness: illness, allergies: allergies)
                    
                } else { // User has profile, update existing
                    print("User has a profile, update it")
                    
                    profileViewModel.upateDetails(fullName: fullName, address: address, birthday: birthday, bloodType: bloodType, illness: illness, allergies: allergies)
                    
                    // presentationMode.wrappedValue.dismiss() // Close modal and return to ProfileView
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
