//
//  AddContactViewModel.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//  Edit by gintare on 10.4.2022.

import SwiftUI

class AddContactViewModel: ObservableObject {
    let profileService = ProfileService.getInstance
    let profileService2 = ProfileService()
    @ObservedObject var ProfileVM = ProfileViewModel()
    
    @Published var connectionDetails: ContactConnectionModel?
    @Published var profileFound = false
    @Published var trustedContactDetails: TrustedContactModel?
    @Published var connectionsPending = false
    @Published var pendingRequest: String? = nil
    @Published var pendingArray = []
    @Published var foundTrustedContacts = false
    @Published var trustedContactList = []
    @Published var trustedContacts: [ProfileModel?]?
    
    private var targetId: String = ""
    
    func findProfile(searchCode: String?) {
        
        //TODO: user shouldn't be able to find themselves or add themselves!!!
        
        // Fetch profile data
        profileService.collection("profiles").whereField("connectionCode", isEqualTo: searchCode!).getDocuments() { snapshot, error in
            if let error = error {
                print("Error fetching profile: \(error)")
            } else {
                if snapshot!.count < 1 {
                    self.profileFound = false
                    print("Profile not found")
                    return
                }
                
                for document in snapshot!.documents {
                    self.profileFound = true
                    print("Profile found with ID: \(document.documentID)")
                    self.targetId = document["userId"] as! String
                    let profileId = document.documentID
                    let fullName = document["fullName"]
                    
                    // Update @Published object in main thread with Trusted Contact details
                    DispatchQueue.main.async {
                        self.trustedContactDetails = TrustedContactModel(id: profileId, userId: self.targetId , fullName: fullName as! String)
                    }
                }
            }
        }
    } // end of findProfile()
    
    
    // Add user as trusted contact and create a new entry in 'connections' collection
    func addTrustedContact() {
        var hasher = Hasher()
        hasher.combine(AuthenticationService.getInstance.currentUser!.uid)
        hasher.combine(targetId)
        let connectionId = String(hasher.finalize())
        
        // Save data in database
        profileService.collection("connections").addDocument(
            data:[
                "connectionId": connectionId,
                "ownerId": AuthenticationService.getInstance.currentUser!.uid,
                "targetId": targetId,
                "status": false
            ]) { error in
                if error == nil {
                    // TODO: If successful this should trigger a notification sent to target user (Sprint 3?)
                    print("Connection created with ID: \(connectionId)")
                    self.profileFound = false
                } else {
                    // Connection wasn't created
                    print("Failed to add trusted contact")
                }
            }
    } // end of addTrustedContact()
    
    // fetch all pending requests for logged in user
    func getPendingConnectionRequests() {
        self.pendingArray = []

        profileService.collection("connections").whereField("status", isEqualTo: false).whereField("targetId", isEqualTo: AuthenticationService.getInstance.currentUser!.uid).getDocuments() { snapshot, error in
            if let error = error {
                print("Error fetching connection requests \(error)")
            } else {
                if snapshot!.count < 1 {
                    self.connectionsPending = false
                    print("There are no pending connection requests")
                    return
                }
            }
            
            for document in snapshot!.documents {
                self.connectionsPending = true
                print("There is a pending request with Id: \(document.documentID)")
                
                
                self.pendingRequest = document.documentID
                
                let tcId = document["ownerId"]
                self.pendingArray.append(tcId as! String)
                print(self.pendingArray)
            }
        }
    } // end of getPendingConnectionRequests()
    
    // confirm pending requests
    func confirmConnectionRequest() {
        if pendingRequest == nil {
            print("There is nothing to confirm")
        } else {
            profileService.collection("connections").document(pendingRequest!).setData(["status": true], merge: true) { error in
                if error == nil {
                    print("Request confirmed")
                    self.pendingRequest = nil
                    self.getPendingConnectionRequests()
                } else {
                    print("Error confirming connection request")
                }
            }
        }
    }
    
    
    // TODO: unfinished
    // fetch all user's trusted contacts
    func fetchAllUsersContacts() {
        self.trustedContactList = []
        
        profileService.collection("connections").whereField("targetId", isEqualTo: "fYicGXYa9eWWKxp8nsuehv0fYAV2").whereField("status", isEqualTo: true).getDocuments() { snapshot, error in
            if let error = error {
                print("Error fetching contacts: \(error)")
            } else {
                if snapshot!.count < 1 {
                    self.foundTrustedContacts = false
                    print("No trusted contacts yet")
                    return
                }
                for document in snapshot!.documents {
                    print("Snapshot: \(document["ownerId"] ?? "")")
                    
                    self.foundTrustedContacts = true
                    let tcId = document["ownerId"]
                    self.trustedContactList.append(tcId!)
                    print("Trusted contact list: \(self.trustedContactList)")
                    
                    print("before calling ser")
                
                    
                    let tContacts = self.profileService2.getProfiles(for: tcId as! String)
                    print("trusted contacats: \(tContacts)")
                    
                    DispatchQueue.main.async {
                        self.trustedContacts = self.profileService2.getProfiles(for: tcId as! String)
                    }
                    
                }
            }
        }
    }
}
