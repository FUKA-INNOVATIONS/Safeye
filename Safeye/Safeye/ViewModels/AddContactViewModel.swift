//
//  AddContactViewModel.swift
//  Safeye
//
//  Created by FUKA on 1.4.2022.
//  Edit by gintare on 10.4.2022.

import SwiftUI

class AddContactViewModel: ObservableObject {
    let profileService = ProfileService.getInstance
    let userId = AuthenticationService.getInstance.currentUser!.uid
    
    @Published var connectionDetails: ContactConnectionModel?
    @Published var profileFound = false
    @Published var trustedContactDetails: TrustedContactModel?
    @Published var connectionsPending = false
    @Published var pendingRequest: String = ""
    @Published var foundTrustedContacts = false
    
    var targetId: String = ""
    
    func findProfile(searchCode: String?) {
        
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
        hasher.combine(userId)
        hasher.combine(targetId)
        let connectionId = String(hasher.finalize())
        
        // Save data in database
        profileService.collection("connections").addDocument(
            data:[
                "connectionId": connectionId,
                "ownerId": userId,
                "targetId": targetId,
                "status": false
            ]) { error in
                if error == nil {
                    // TODO: If successful this should trigger a notification sent to target user
                    print("Connection created with ID: \(connectionId)")
                } else {
                    // Connection wasn't created
                    print("Failed to add trusted contact")
                }
            }
    } // end of addTrustedContact()
    
    
    func getPendingConnectionRequests() {
        
        profileService.collection("connections").whereField("status", isEqualTo: false).whereField("targetId", isEqualTo: userId).getDocuments() { snapshot, error in
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
            }
        }
    } // end of getPendingConnectionRequests()
    
    func confirmConnectionRequest() {
        profileService.collection("connections").document(pendingRequest).setData(["status": true], merge: true) { error in
            if error == nil {
                print("Request confirmed")
            } else {
                print("Error confirming connection request")
            }
        }
    }
    
    
    // TODO: unfinished
    func fetchAllUsersContacts() {
        profileService.collection("connections").whereField("targetId", isEqualTo: userId).whereField("status", isEqualTo: true).getDocuments() { snapshot, error in
            if let error = error {
                print("Error fetching contacts: \(error)")
            } else {
                if snapshot!.count < 1 {
                    self.foundTrustedContacts = false
                    print("No trusted contacts yet")
                    return
                }
                for document in snapshot!.documents {
                    self.foundTrustedContacts = true
                    print("Found trusted contacts")
                }
            }
        }
    }
}
