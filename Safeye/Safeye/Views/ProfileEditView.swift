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
    @EnvironmentObject var EventVM: EventViewModel
    @EnvironmentObject var FileVM: FileViewModel
    
    @State private var showEmptyFieldAlert = false
    
    @Environment(\.dismiss) var dismiss
    
    @State private var fullName = ""
    @State private var address = ""
    @State private var birthday = ""
    @State private var bloodType = ""
    @State private var illness = ""
    @State private var allergies = ""
    @State private var connectionCode = ""
    @State private var avatar = ""
    
    @State private var bloodTypes = ["A", "A+", "B"]
    
    @State var isImagePickerShowing = false
    @State var selectedPhoto: UIImage?
    
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
                self.avatar = self.appState.profile!.avatar
            }
        }
        
        return VStack() {
            if self.appState.profile != nil {
                Text("Please fill the fileds you want to update")
                
            } else {
                Text("Please fill all fields to create new profile")
            }
            
            
            
            
            HStack { // Display profile photo
                if selectedPhoto != nil { // if user has picked a new photo, show that one
                    ProfileImageComponent(size: 60, avatarImage: selectedPhoto!)
                } else if appState.userPhoto != nil { // if user hasn't selected a new photo, fetch one from DB if they have it
                    ProfileImageComponent(size: 60, avatarImage: appState.userPhoto!)
                } else { // otherwise show placeholder image
                    ProfileImageComponent(size: 40, avatarImage: UIImage(imageLiteralResourceName: "avatar-placeholder"))
                }
                Button {
                    isImagePickerShowing = true
                } label: {
                    Text("Select profile photo")
                }
                
            }
            .sheet(isPresented: $isImagePickerShowing, onDismiss: nil) {
                // Image picker
                ImagePicker(selectedPhoto: $selectedPhoto, isImagePickerShowing: $isImagePickerShowing)  // this opens ImagePicker helper
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
                        Picker("Blood type", selection: $bloodType) {
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
                    
                    // User has not filled all form fields
                    // TODO: show different alert when no photo is selected
                    if fullName.count < 1 || address.count < 1 || birthday.count < 1 || bloodType.count < 1 || illness.count < 1 || allergies.count < 1 || selectedPhoto == nil {
                        self.showEmptyFieldAlert = true // Show alert box
                        return
                    }
                    
                    // set avatar path/name to a random string that will be stored in profile // TODO: change avatar path name > userID
                    self.avatar = "avatars/\(UUID().uuidString).jpg"
                    // upload the image
                    FileVM.uploadPhoto(selectedPhoto: selectedPhoto, avatarUrlFetched: self.avatar)
                    
                    // Insert new profile data into the database
                    ProfileVM.createProfile(fullName, address, birthday, bloodType, illness, allergies, avatar)
                    
                    // presentationMode.wrappedValue.dismiss() // Close modal and return to ContentView()
                    dismiss()
                    
                    
                } else { // User has profile, update existing
                    print("User has a profile, update it")
                    
                    // User has not filled all form fields
                    if fullName.count < 1 || address.count < 1 || birthday.count < 1 || bloodType.count < 1 || illness.count < 1 || allergies.count < 1 {
                        self.showEmptyFieldAlert = true // Show alert box
                        return
                    }
                    
                    // set avatar path/name to current avatar path fetched from user's profile
                    let avatarUrlFetched = appState.profile!.avatar
                    // upload the image
                    FileVM.uploadPhoto(selectedPhoto: selectedPhoto, avatarUrlFetched: avatarUrlFetched)
                    self.avatar = avatarUrlFetched
                    
                    // Update profile data in the database
                    ProfileVM.updateProfile(fullName, address, birthday, bloodType, illness, allergies, avatar)
                    
                    // presentationMode.wrappedValue.dismiss() // Close modal and return to ProfileView
                    appState.userPhoto = selectedPhoto
                    selectedPhoto = nil
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
