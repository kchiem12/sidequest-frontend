//
//  SimpleImage.swift
//  sidequest1
//
//  Created by Ken Chiem on 11/27/22.
//

import Foundation

// UIImageView.sd_setImage(URL, placeholder image if no url)
struct SimpleImage: Codable {
    let id: Int?
    var url: String?
    var created_at: String?
}
