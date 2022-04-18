//
//  FileViewModel.swift
//  Safeye
//
//  Created by gintare on 14.4.2022.
//

import SwiftUI

class FileViewModel: ObservableObject {
    static let shared = FileViewModel(); private init() {}
    private let appStore = Store.shared
    let fileService = FileService.shared
    @State var selectedPhoto: UIImage?
    @Published var avatarExists = false
    @Published var fetchedPhoto: UIImage?
    @Published var avatarUrl: String = ""
    // @Published var retrievedImages = [UIImage?]()

    // upload a photo
    func uploadPhoto(selectedPhoto: UIImage?, avatarUrlFetched: String) {
        // avatarUrlFetched is either the existing avatar path fetched from user profile or a random code if user doesn't have a profile
        // it's coming from ProfileEditView. It seems to work better this way.
            self.avatarUrl = avatarUrlFetched
            self.avatarUrl = fileService.putPhoto(selectedPhoto, avatarUrl) // this resets the profile url. Technically it's the same as the previous line, so it shouldn't be needed. TODO: test a bit more to make sure it's unnecessary to assign new avatarURL value.
    }
    
    // fetch a single photo
    func fetchPhoto(avatarUrlFetched: String?) {
        self.fetchedPhoto = fileService.getPhoto(avatarUrlFetched: avatarUrlFetched)
    }
    
}
