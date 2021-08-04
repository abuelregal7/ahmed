//
//  ImagePickerEX.swift
//  Task
//
//  Created by Ahmed on 8/4/21.
//

import Foundation
import UIKit

extension UpdateVC {
    
    public func presentInputActionSheet() {
        
        let actionSheet = UIAlertController(title: "Attach Media",
                                            message: "What would you like to attach?",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Photo",
                                            style: .default,
                                            handler: { [weak self] _ in
                                                guard let self = self else { return }
                                                self.presentPhotoInputActionSheet()
                                            }))
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        present(actionSheet, animated: true, completion: nil)
        
    }
    
    private func presentPhotoInputActionSheet() {
        
        let actionSheet = UIAlertController(title: "Attach Photo",
                                            message: "What would you like to attach photo from?",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera",
                                            style: .default,
                                            handler: { [weak self] _ in
                                                guard let self = self else { return }
                                                
                                                self.presentCamera()
                                                
                                            }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library",
                                            style: .default,
                                            handler: { [weak self] _ in
                                                guard let self = self else { return }
                                                
                                                self.presentLibrary()
                                                
                                            }))
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        present(actionSheet, animated: true, completion: nil)
        
    }
    
}

extension UpdateVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Mark: - Open camera for photo
    func presentCamera() {
        
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        
    }
    // Mark: - Open camera for video
    func presentVideoCamera() {
        
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.mediaTypes = ["public.movie"]
        vc.videoQuality = .typeMedium
        vc.allowsEditing = true
        present(vc, animated: true)
        
    }
    
    // Mark: - Open library
    func presentLibrary() {
        
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        
    }
    
    // Mark: - Open library for video
    func presentVideoLibrary() {
        
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        vc.mediaTypes = ["public.movie"]
        vc.videoQuality = .typeMedium
        //vc.videoExportPreset = "AVAssetExportPresetHEVC1920x1080"
        present(vc, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

       // The info dictionary may contain multiple representations of the image. You want to use the original.
       guard let selectedImage = info[.originalImage] as? UIImage else {
           fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
       }
        
       // Set photoImageView to display the selected image.
       image.image = selectedImage
       
       // Dismiss the picker.
       dismiss(animated: true, completion: nil)
   }
    
}
