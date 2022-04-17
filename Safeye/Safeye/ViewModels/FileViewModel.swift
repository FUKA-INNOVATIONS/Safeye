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
    private let appStore = Store.shared

    // upload a photo
    func uploadPhoto(selectedPhoto: UIImage?, avatarUrlFetched: String) {
            self.avatarUrl = avatarUrlFetched
            self.avatarUrl = fileService.putPhoto(selectedPhoto, avatarUrl)
    }
    
    // fetch photos
    func fetchPhoto(avatarUrlFetched: String?) {
        self.fetchedPhoto = fileService.getPhoto(avatarUrlFetched: avatarUrlFetched)
    }
    
}
