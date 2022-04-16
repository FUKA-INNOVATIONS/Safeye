//
//  ImagePicker.swift
//  Safeye
//
//  Created by gintare on 14.4.2022.
//

import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedPhoto: UIImage?
    @EnvironmentObject var FileVM: FileViewModel
    @Binding var isImagePickerShowing: Bool
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        
        //  when the user selects a photo, the UIViewController will contact the delegate and call its methods
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // todo
    }
    
    func makeCoordinator() -> Coordinator {
        // pass a refrence of itself throught to the coordinator
        return Coordinator(self)
    }
}

class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var parent: ImagePicker
    
    init(_ picker: ImagePicker) {
        self.parent = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // run code when the user has selected an image        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            DispatchQueue.main.async {
                self.parent.selectedPhoto = image
            }
        }
        //Dismiss the picker
        parent.isImagePickerShowing = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // run code when the user has cancelled the picker UI
        parent.isImagePickerShowing = false
    }
}

