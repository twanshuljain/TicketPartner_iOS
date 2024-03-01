//
//  UIImage+Extension.swift
//  TicketSpark
//
//  Created by Apple on 01/03/24.
//

import UIKit

extension UIImage {
    func convertImagesToData() -> [Data] {
        var imageDataArray: [Data] = []

        for image in [self] {
            // Convert image to data
            if let imageData = image.pngData() { // Use pngData() or jpegData(compressionQuality:) depending on your preference
                imageDataArray.append(imageData)
            }
        }

        return imageDataArray
    }
    
    func convertImageToData() -> Data {
        if let imageData = self.pngData() { // Use pngData() or jpegData(compressionQuality:) depending on your preference
            return imageData
        }
        return Data()
    }
}
