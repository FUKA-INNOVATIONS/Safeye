//
//  FileService.swift
//  Safeye
//
//  Created by gintare on 14.4.2022.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore

class FileService {
    static let shared = FileService() ; private init() {}
    private let storageRef = Storage.storage().reference()
    private let path = "avatars/\(UUID().uuidString).jpg"
    private let fileDB = Firestore.firestore()
    
    private let appStore = Store.shared
    // private var fetchedPhotos: [UIImage?] = []
    
    private var fetchedPhoto: UIImage?
    
    
    func getPhotos() -> UIImage? {
        fetchPhotos()
        return fetchedPhoto
    }
    
    func putPhoto(_ selectedPhoto: UIImage?) -> String {
        uploadPhoto(selectedPhoto)
        return self.path
    }
    
    func uploadPhoto(_ selectedPhoto: UIImage?) {
        // Make sure that selected image property isn't nil
        guard selectedPhoto != nil else {
            return
        }
        
        // Create storage reference
        // let storageRef = Storage.storage().reference()
        
        // Turn image into data
        let imageData = selectedPhoto!.jpegData(compressionQuality: 0.05)
        // check that we were able to convert it to data
        guard imageData != nil else {
            return
        }
        // Specify the file path and name
        // let path = "avatars/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)
        // Upload data
        fileRef.putData(imageData!, metadata: nil) { metadata, error in
            // checks for errors
            if error == nil && metadata != nil {
                // Save a reference to the file in database
                // let db = Firestore.firestore()
                //                self.fileDB.collection("avatars").document().setData(["url":self.path]) { error in
                //                    if error == nil {
                //                        DispatchQueue.main.async {
                //                            // Add uploaded image to the list of uploaded images for display
                //                            // self.fetchedImages.append(selectedPhoto!)
                //                            self.fetchedPhoto = selectedPhoto!
                //                        }
                //
                //                    }
                //                }
            }
        }
        
        
    }
    
    func fetchPhotos() {
        // Get the data from the database
        fileDB.collection("avatars").whereField("name", isEqualTo: self.appStore.profile?.avatar ?? "").getDocuments { snapshot, error in
            if error == nil && snapshot != nil {
                var path = ""
                
                for doc in snapshot!.documents {
                    // extract the file path
                    path = doc["url"] as! String
                }
                
                // fetch the data from storage
                // get a reference to storage
                let storageRef = Storage.storage().reference()
                let fileRef = storageRef.child(path)
                // specify the path
                fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                    if error == nil && data != nil {
                        // Create a UIImage and put it into the array for display
                        if let image = UIImage(data: data!) {
                            DispatchQueue.main.async {
                                //self.fetchedImages.append(image)
                                self.fetchedPhoto = image
                            }
                        }
                    }
                }
            }
        }
    }
}



//    func fetchPhotos()  {
//        // Get the data from the database
//        // let db = Firestore.firestore(
//        fileDB.collection("avatars").getDocuments { snapshot, error in
//            if error == nil && snapshot != nil {
//                var paths = [String]()
//
//                for doc in snapshot!.documents {
//                    // extract the file path and add to array
//                    paths.append(doc["url"] as! String)
//                }
//                // loop through each file path and fetch the date from storage
//                for path in paths {
//
//                    // get a reference to storage
//                    let storageRef = Storage.storage().reference()
//                    let fileRef = storageRef.child(path)
//                    // specify the path
//                    fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
//                        if error == nil && data != nil {
//                            // Create a UIImage and put it into the array for display
//                            if let image = UIImage(data: data!) {
//                                DispatchQueue.main.async {
//                                    //self.fetchedImages.append(image)
//                                    self.fetchedPhoto = image
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
//}

