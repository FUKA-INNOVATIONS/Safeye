//
//  ProfileEditView.swift
//  Safeye
//
//  Created by Safeye Team on 1.4.2022.
//
/*
 Here you can add phopto tou your profile, edit Your Firast name and Last name, and other details about user, you can acceses this from Profile view.
 */
import SwiftUI

struct ProfileEditView: View {
    
    @EnvironmentObject var ProfileVM: ProfileViewModel
    @EnvironmentObject var AuthVM: AuthenticationViewModel
    @EnvironmentObject var appState: Store
    @EnvironmentObject var EventVM: EventViewModel
    @EnvironmentObject var FileVM: FileViewModel
    var translationManager = TranslationService.shared
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject private var CityVM: CityViewModel
    @State private var showEmptyFieldAlert = false
    @Environment(\.dismiss) var dismiss
    @State private var fullName = ""
    @State private var address = ""
    @State private var birthdate = Date()
    @State private var birthday = ""
    @State private var bloodType = ""
    @State private var illness = ""
    @State private var allergies = ""
    @State private var connectionCode = ""
    @State private var avatar = ""
    @State private var bloodTypes = ["A", "B", "AB", "O"]
    @State private var countries = ["Finland","Sweden", "Estonia", "Denmark", "Norway"]
    @State private var selectedCountry = "Finland"
    @State var isImagePickerShowing = false
    @State var selectedPhoto: UIImage?
    
    var body: some View {
        
        // Profile exists and user has all profile details, prefill all fields
        if appState.profile != nil {
            let birthdayFormatter = DateFormatter()
            birthdayFormatter.dateFormat = "dd-MM-yyyy"
            DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                fullName = appState.profile!.fullName
                address = appState.profile!.address
                birthday = appState.profile!.birthday
                birthdate = birthdayFormatter.date(from: birthday)!
                bloodType = appState.profile!.bloodType
                illness = appState.profile!.illness
                allergies = appState.profile!.allergies
                avatar = appState.profile!.avatar
            }
        }
        
        return VStack {
            ScrollView {
                VStack {
                    if appState.profile != nil {
                        Text(translationManager.textProfileUpdate)
                            .font(.headline)
                        
                    } else {
                        Text(translationManager.textProfileBlanc)
                            .font(.headline)
                    }
                }
                .padding(20)
                
                
                VStack { // Display profile photo
                    if selectedPhoto != nil { // if user has picked a new photo, show that one
                        ProfileImageComponent(size: 60, avatarImage: selectedPhoto!)
                    } else if appState.userPhoto != nil { // if user hasn't selected a new photo, fetch one from DB if they have it
                        ProfileImageComponent(size: 60, avatarImage: appState.userPhoto!)
                    } else { // otherwise show placeholder image
                        ProfileImageComponent(size: 75, avatarImage: UIImage(imageLiteralResourceName: "avatar-placeholder"))
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
                
                //
                if appState.profile == nil {
                    HStack { // Picker for country of residence
                        Text("Country")
                        Spacer()
                        Section {
                            Picker("Country", selection: $selectedCountry) {
                                ForEach(countries, id: \.self) { country in
                                    Text(country)
                                }
                            }
                        }
                    }.padding()
                }
                
                HStack{
                    LoginInputComponent(title: translationManager.fullNameTitle, inputText: $fullName, icon: "person.fill")
                }
                
                HStack{
                    LoginInputComponent(title: translationManager.addressTitle, inputText: $address, icon: "map.fill")
                }
                HStack{
                    DatePicker("Birthdate", selection: $birthdate, in: ...Date(), displayedComponents: .date)
                    //LoginInputComponent(title: translationManager.birthdayTitle, inputText: $birthday, icon: "calendar.circle.fill")
                }
                .frame(width: 350)
                HStack{
                    VStack(alignment: .leading){
                        
                        // Select blood type
                        Section { // Sections can have header and footer
                            Picker(translationManager.bloodTypeTitle, selection: $bloodType) {
                                ForEach(bloodTypes, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        } header: {
                            Text(translationManager.bloodTitle)
                        }
                        .padding()
                        
                        LoginInputComponent(title: translationManager.illnessTitle, inputText: $illness, icon: "stethoscope.circle.fill")
                        LoginInputComponent(title: translationManager.allergiesTitle, inputText: $allergies, icon: "exclamationmark.triangle.fill")
                    }
                }
                
                BasicButtonComponent(label: translationManager.saveBtn) {
                    print("Save profile details pressed")
                    
                    print(selectedCountry)
                    
                    let birthdayFormatter = DateFormatter()
                    birthdayFormatter.dateFormat = "dd-MM-yyyy"
                    birthday = birthdayFormatter.string(from: birthdate)
                    
                    if appState.profile == nil { // User has no profile, create new one
                        print("User has no PROFILE, add new profile")
                        
                        // User has not filled all form fields
                        // TODO: show different alert when no photo is selected
                        if fullName.count < 1 || address.count < 1 || bloodType.count < 1 || illness.count < 1 || allergies.count < 1 || selectedPhoto == nil || selectedCountry.count < 0 {
                            showEmptyFieldAlert = true // Show alert box
                            return
                        }
                        
                        // set avatar path/name to a random string that will be stored in profile // TODO: change avatar path name > userID
                        avatar = "avatars/\(UUID().uuidString).jpg"
                        // upload the image
                        FileVM.uploadPhoto(selectedPhoto: selectedPhoto, avatarUrlFetched: avatar)
                        
                        // Insert new profile data into the database
                        ProfileVM.createProfile(fullName, address, birthday, bloodType, illness, allergies, avatar)
                        
                        saveCitiesInDevice(of: selectedCountry) // fetch cities and save in user device > coreData
                        
                        dismiss() // Close modal
                        
                        
                    } else { // User has profile, update existing
                        print("User has a profile, update it")
                        
                        // User has not filled all form fields
                        if fullName.count < 1 || address.count < 1 || bloodType.count < 1 || illness.count < 1 || allergies.count < 1 {
                            showEmptyFieldAlert = true // Show alert box
                            return
                        }
                        
                        // set avatar path/name to current avatar path fetched from user's profile
                        let avatarUrlFetched = appState.profile!.avatar
                        // upload the image
                        FileVM.uploadPhoto(selectedPhoto: selectedPhoto, avatarUrlFetched: avatarUrlFetched)
                        self.avatar = avatarUrlFetched
                        
                        // Update profile data in the database
                        ProfileVM.updateProfile(fullName, address, birthday, bloodType, illness, allergies, avatar)
                        
                        appState.userPhoto = selectedPhoto
                        dismiss() // close Modal
                    }
                }
                .alert(isPresented: $showEmptyFieldAlert) { // Alert user about emptu fields
                    Alert(
                        title: Text(translationManager.fieldAlertTitle),
                        message: Text(translationManager.fieldAlertText)
                    )
                }
            }
        }
    }
    
    func saveCitiesInDevice(of userSelectedCountry: String) {
        CityVM.getCities(of: userSelectedCountry)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            // save all cities in device momeory
            for city in appState.cities {
                let c = City(context: moc)
                c.id = UUID()
                c.name = city
                c.country = userSelectedCountry
            }
            
            // save all cities in device persistant storage if data has changed
            if moc.hasChanges {
                do {
                    try moc.save()
                    print("CoreData: Cities saved")
                } catch {
                    print("CoreData: Error while saving citites into device \(error.localizedDescription)")
                }
            } else { print("CoreData: Cities not saved in device beause of no changes") }
        }
    }
}
