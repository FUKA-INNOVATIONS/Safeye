//
//  FileViewModel.swift
//  Safeye
//
//  Created by Safeye team on 14.4.2022.
//

/*
    This class communicates with the FileService, and is responsible for handling fetching and
    retrieve of the users avatar, It has two functionalities, one for the user to upload a photo
    and one to retrieve it so it can be displayed to the user.
 */

import SwiftUI

class FileViewModel: ObservableObject {
    static let shared = FileViewModel(); private init() {}
    private let appStore = Store.shared
    let fileService = FileService.shared
    @State var selectedPhoto: UIImage?
    @Published var avatarExists = false
    @Published var avatarUrl: String = ""
    
    // upload a photo
    func uploadPhoto(selectedPhoto: UIImage?, avatarUrlFetched: String) {
        // avatarUrlFetched is either the existing avatar path fetched from user profile or a random code if user doesn't have a profile
        // it's coming from ProfileEditView
        self.avatarUrl = fileService.putPhoto(selectedPhoto, avatarUrlFetched)
    }
    
    // fetch a single photo
    func fetchPhoto(avatarUrlFetched: String?, isSearchResultPhoto: Bool = false, isTrustedContactPhoto: Bool = false) {
        fileService.fetchPhoto(avatarUrlFetched: avatarUrlFetched, isSearchResultPhoto: isSearchResultPhoto, isTrustedContactPhoto: isTrustedContactPhoto)
    }
    
}
