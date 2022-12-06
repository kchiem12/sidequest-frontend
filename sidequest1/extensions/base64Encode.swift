//
//  base64Encode.swift
//  sidequest1
//
//  Created by Ken Chiem on 12/6/22.
//

import UIKit

class base64Encode {
    
    // Converts the UIImage to Base64 String
    static func convertImageToBase64String (img: UIImage) -> String {
        let extensionBase = img.jpegData(compressionQuality: 0.7)?.base64EncodedString(options: .lineLength64Characters) ?? ""
        return "data:image/jpeg;base64,\(extensionBase)"
    }
}
