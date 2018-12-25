//
//  ImagePickerManager.swift
//  Instabug-iOS-Assessment
//
//  Created by ahmed mahdy on 12/22/18.
//  Copyright © 2018 ahmed mahdy. All rights reserved.
//

import Foundation
import UIKit
import Photos


class ImagePickerManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var picker = UIImagePickerController()
    var alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
    var viewController: UIViewController?
    var pickImageCallback : ((URL) -> ())?
    var isAuthorized: Bool = false
    
    override init(){
        super.init()
        checkPermission()
    }
    func checkPermission(){
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            isAuthorized = true
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({[weak self]
                (newStatus)  in
                if newStatus ==  PHAuthorizationStatus.authorized {
                    self?.isAuthorized = true
                }
                
            })
        case .restricted:
            isAuthorized = false
        case .denied:
            isAuthorized = false
        }
        
    }
    
    func pickImage(_ viewController: UIViewController, _ callback: @escaping ((URL) -> ())) {
        if isAuthorized {
        pickImageCallback = callback
        self.viewController = viewController
        checkPermission()
        
        let gallaryAction = UIAlertAction(title: "Gallary", style: .default){
            UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){
            UIAlertAction in
        }
        
        picker.delegate = self
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        alert.popoverPresentationController?.sourceView = self.viewController!.view
        viewController.present(alert, animated: true, completion: nil)
        }
    }
    func openGallery(){
        alert.dismiss(animated: true, completion: nil)
        picker.sourceType = .photoLibrary
        self.viewController!.present(picker, animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
          picker.dismiss(animated: true, completion: nil)
          let imageURL = info[UIImagePickerController.InfoKey.imageURL] as! URL
          pickImageCallback?(imageURL)
      }
}

