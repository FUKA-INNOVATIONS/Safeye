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
    @Published var avatarUrl: String = "avatars/\(UUID().uuidString).jpg"
    private let appStore = Store.shared

    // upload a photo
    func uploadPhoto(selectedPhoto: UIImage?, avatarUrlFetched: String?) {
        if avatarUrlFetched != nil {
            self.avatarUrl = avatarUrlFetched!
        } 
        self.avatarUrl = fileService.putPhoto(selectedPhoto, avatarUrl)
    }
    
    // fetch photos
    // fetched all photos in avatar folder
    // TODO: this should pass userId and retrieve only users avatar
    func fetchPhotos() {
        self.fetchedPhoto = fileService.getPhotos()
    }
    
}
