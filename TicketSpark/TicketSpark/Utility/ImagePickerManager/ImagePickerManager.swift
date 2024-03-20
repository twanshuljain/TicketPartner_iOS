//
//  ImagePickerManager.swift
//  TicketSpark
//
//  Created by Apple on 26/02/24.
//

import Foundation
import UIKit
import AVFoundation
import BSImagePicker
import Photos
import FMPhotoPicker

class ImagePickerManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var picker = UIImagePickerController();
    var bsPicker = ImagePickerController()
    var alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
    var viewController: UIViewController?
    var pickImageCallback : ((UIImage) -> ())?;
    var pickMultipleImageCallback : (([UIImage]) -> ())?;
    var multipleSelectionAllow = false
    var selectedAssets: [PHAsset] = []
    var config = FMPhotoPickerConfig()
    
    override init(){
        super.init()
        let cameraAction = UIAlertAction(title: "Camera", style: .default){
            UIAlertAction in
            self.openCamera(viewController: self.viewController)
        }
        let galleryAction = UIAlertAction(title: "Gallery", style: .default){
            UIAlertAction in
            if self.multipleSelectionAllow {
                self.openMultipleImagesGallery(viewController: self.viewController)
            } else {
                self.openGallery(viewController: self.viewController)
            }
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){
            UIAlertAction in
        }

        // Add the actions
        picker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
    }
    
    
//    init(viewController: UIViewController?) {
//        self.viewController = viewController
//    }

    func pickImage(_ viewController: UIViewController, _ callback: @escaping ((UIImage) -> ())) {
        pickImageCallback = callback;
        self.viewController = viewController;
        alert.popoverPresentationController?.sourceView = self.viewController!.view
        viewController.present(alert, animated: true, completion: nil)
    }
    
    func pickMultipleImage(_ viewController: UIViewController, _ multipleImages: Bool? = true, _ callback: @escaping (([UIImage]) -> ())) {
        self.multipleSelectionAllow = multipleImages ?? true
        pickMultipleImageCallback = callback;
        self.viewController = viewController;
        alert.popoverPresentationController?.sourceView = self.viewController!.view
        viewController.present(alert, animated: true, completion: nil)
    }
    
    
    func openCamera(viewController:UIViewController?){
        self.viewController = viewController
        alert.dismiss(animated: true, completion: nil)
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            checkCameraPermission { isEnable in
                if isEnable {
                    self.picker.sourceType = .camera
                    self.viewController!.present(self.picker, animated: true, completion: nil)
                }
            }
        } else {
            let alertController: UIAlertController = {
                let controller = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default)
                controller.addAction(action)
                return controller
            }()
            viewController?.present(alertController, animated: true)
        }
    }
    func checkCameraPermission(isEnable: @escaping (Bool) -> Void) {
        if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
            print("Already Authorized")
            isEnable(true)
        } else {
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted: Bool) -> Void in
               if granted == true {
                   print("User granted")
                   isEnable(true)
               } else {
                   // Popup for Navigate to Settings
                   let alertController: UIAlertController = {
                       let controller = UIAlertController(title: "Alert", message: "Please allow the camera permission from the settings.", preferredStyle: .alert)
                       let cancel = UIAlertAction(title: "Cancel", style: .default)
                       let settings = UIAlertAction(title: "Settings", style: .default) { (action:UIAlertAction!) in
                           print("Settings tapped")
                           if let url = URL(string: UIApplication.openSettingsURLString) {
                               if UIApplication.shared.canOpenURL(url) {
                                   DispatchQueue.main.async {
                                       UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                   }
                               }
                           }
                       }
                       controller.addAction(cancel)
                       controller.addAction(settings)
                       return controller
                   }()
                   DispatchQueue.main.async {
                       self.viewController?.present(alertController, animated: true)
                   }
               }
           })
        }
    }
//    func openGallery(viewController:UIViewController?){
//        self.viewController = viewController
//        alert.dismiss(animated: true, completion: nil)
//        picker.sourceType = .photoLibrary
//        self.viewController!.present(picker, animated: true, completion: nil)
//    }
    
    func openGallery(viewController:UIViewController?){
        self.viewController = viewController
        alert.dismiss(animated: true, completion: nil)
        self.config.availableFilters = nil
        self.config.maxImage = 1
        let picker = FMPhotoPickerViewController(config: config)
        picker.delegate = self
        self.viewController!.present(picker, animated: true, completion: nil)
    }
    
    func openMultipleImagesGallery(viewController:UIViewController?){
        self.viewController = viewController
        alert.dismiss(animated: true, completion: nil)
        self.config.availableFilters = nil
        self.config.maxImage = 15
        let picker = FMPhotoPickerViewController(config: config)
        picker.delegate = self
        self.viewController!.present(picker, animated: true, completion: nil)
    }
    
//    func openMultipleImagesGallery(viewController:UIViewController?){
//        self.viewController = viewController
//        alert.dismiss(animated: true, completion: nil)
//        bsPicker.settings.selection.max = 15
//        bsPicker.settings.selection.unselectOnReachingMax = true
//        bsPicker.settings.fetch.assets.supportedMediaTypes = [.image]
//
//        bsPicker.settings.list.cellsPerRow = {(verticalSize: UIUserInterfaceSizeClass, horizontalSize: UIUserInterfaceSizeClass) -> Int in
//            switch (verticalSize, horizontalSize) {
//            case (.compact, .regular): // iPhone5-6 portrait
//                return 2
//            case (.compact, .compact): // iPhone5-6 landscape
//                return 2
//            case (.regular, .regular): // iPad portrait/landscape
//                return 3
//            default:
//                return 2
//            }
//        }
//        // Present the image picker
//        self.viewController?.presentImagePicker(bsPicker, select: { (asset) in
//            // Image selected
//            print("Selected asset: \(asset)")
//            self.selectedAssets.append(asset) // Add the selected asset to the array
//        }, deselect: { (asset) in
//            // Image deselected
//            print("Deselected asset: \(asset)")
//            if let index = self.selectedAssets.firstIndex(of: asset) {
//                self.selectedAssets.remove(at: index) // Remove the deselected asset from the array
//            }
//        }, cancel: { (assets) in
//            // Image picker cancelled
//            print("Image picker cancelled")
//        }, finish: { (assets) in
//            // Image picker finished selecting images
//            print("Selected assets: \(assets)")
//            self.selectedAssets = assets // Update the array with the selected assets
//
//            // Fetch UIImage objects corresponding to the selected PHAsset objects
//            self.fetchImages()
//        }, completion: nil)
//    }
    
    func fetchImages() {
            PHImageManager.fetchImages(for: selectedAssets, targetSize: CGSize(width: 200, height: 200)) { images in
                // Use the array of UIImage objects
                self.pickMultipleImageCallback?(images)
            }
        }

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    //for swift below 4.2
    //func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    //    picker.dismiss(animated: true, completion: nil)
    //    let image = info[UIImagePickerControllerOriginalImage] as! UIImage
    //    pickImageCallback?(image)
    //}
    
    // For Swift 4.2+
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        pickImageCallback?(image)
    }



    @objc func imagePickerController(_ picker: UIImagePickerController, pickedImage: UIImage?) {
    }

}

extension ImagePickerManager: FMPhotoPickerViewControllerDelegate {
    func fmPhotoPickerController(_ picker: FMPhotoPickerViewController, didFinishPickingPhotoWith photos: [UIImage]) {
        picker.dismiss(animated: false) {
            self.pickMultipleImageCallback?(photos)
        }        
    }
}

extension PHImageManager {
    static func fetchImages(for assets: [PHAsset], targetSize: CGSize, completion: @escaping ([UIImage]) -> Void) {
        var images: [UIImage] = []
        let options = PHImageRequestOptions()
        options.isSynchronous = false
        options.deliveryMode = .highQualityFormat
        options.resizeMode = .exact

        let dispatchGroup = DispatchGroup()

        for asset in assets {
            dispatchGroup.enter()

            PHImageManager.default().requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: options) { image, _ in
                if let image = image {
                    images.append(image)
                }
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) {
            completion(images)
        }
    }
}
