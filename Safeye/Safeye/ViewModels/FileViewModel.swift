//
//  FileViewModel.swift
//  Safeye
//
//  Created by gintare on 14.4.2022.
//

import SwiftUI

class FileViewModel: ObservableObject {
    static let shared = FileViewModel(); private init() {}
    let fileService = FileService.shared
    
    @State var selectedPhoto: UIImage?
    @Published var avatarExists = false
    // @Published var retrievedImages = [UIImage?]()
    @Published var fetchedPhoto: UIImage?
    @Published var avatarUrl: String = ""
    
    // TODO: this uploads a photo to avatars folder. Need to associate it with user profile. Maybe put the refrence in user profile
    // upload a photo
    func uploadPhoto(selectedPhoto: UIImage?) {
        self.avatarUrl = fileService.putPhoto(selectedPhoto)
    }
    
    // fetch photos
    // fetched all photos in avatar folder
    // TODO: this should pass userId and retrieve only users avatar
    func fetchPhotos() {
        self.fetchedPhoto = fileService.getPhotos()
    }
    
}
