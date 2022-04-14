//
//  ProfileView.swift
//  Safeye
//
//  Created by gintare on 7.4.2022.
//  Edited by FUKA on 8.4.2022.

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var ProfileVM: ProfileViewModel
    
    @State private var showingEditProfile = false
    @State private var showingAddContact = false

    @ObservedObject var EventVM = EventViewModel.shared
    
    @State private var showingAddSafePlace = false
    
    @State var isImagePickerShowing = false
    @State var selectedImage: UIImage?
    
    
    var body: some View {
        
        ZStack {
            VStack {
                NavigationLink {
                    CreateEventView()
                } label: {
                    Text("Create event")
                }
                
                Group{
                    NavigationLink("Tracking (TEMP)", destination: EventView())
                    
                    Text("\(ProfileVM.profileDetails?.fullName ?? "No name")")
                        .font(.system(size: 25, weight: .bold))
                    
                    // Show edit profile view in a Modal
                    BasicButtonComponent(label: "Edit profile details") {
                        showingEditProfile = true
                    }
                    .sheet(isPresented: $showingEditProfile) {
                        ProfileEditView()
                    }
                    VStack {
                        if selectedImage != nil {
                            Image(uiImage: selectedImage!)
                                .resizable()
                                .frame(width: 70, height: 70)
                        }
                        
                        Button {
                            // show the image picker
                            isImagePickerShowing = true
                        } label: {
                            Text("Select a profile photo")
                        }
                        // AvatarComponent(size: 80)
                    }
                    .sheet(isPresented: $isImagePickerShowing, onDismiss: nil) {
                        // Image picker
                        ImagePicker(selectedImage: $selectedImage, isImagePickerShowing: $isImagePickerShowing)
                    }
                }
                Group {
                    Text("My trusted contacts").font(.system(size: 18, weight: .semibold))
                    HStack{
                        ListViewComponent(item: "avatar", size: 50)
                        Button(action: {
                            showingAddContact = true
                        })
                        { Image("icon-add") }
                        Spacer(minLength: 20)
                    }
                    Spacer()
                }
                UserDetailsComponent()
                Spacer()
                Group {
                    Text("My safe spaces").font(.system(size: 18, weight: .semibold))
                    HStack{
                        //size with icons doesn't work properly, will figure this out later
                        ListViewComponent(item: "safeSpace", size: 40)
                        Button(action: {
                            showingAddSafePlace = true
                            print("modal: ($showingAddSafePlace)")
                        })
                        { Image("icon-add") }
                        Spacer(minLength: 20)
                    }
                    Spacer()
                }
                
                
            }
            .onAppear {
                ProfileVM.getProfile()
            }
            
            AddContactView(isShowing: $showingAddContact, searchInput: "")
            AddSafePlaceView(isShowing: $showingAddSafePlace)
            
        }
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
