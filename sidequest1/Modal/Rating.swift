//
//  Rating.swift
//  sidequest1
//
//  Created by Ken Chiem on 11/27/22.
//

import Foundation

struct Rating: Codable {
    let id: Int
    var rate: Int
    var description: String
    var poster: [SimpleUser]
    var postee: [SimpleUser]
}
