//
//  Account.swift
//  sidequest1
//
//  Created by Ken Chiem on 11/26/22.
//

import Foundation
import UIKit

// The structure of a User
struct User: Codable {
    let id: Int
    var email: String
    var first: String
    var last: String
    var phone_number: Int
    var assets: [SimpleImage]
    var job_as_poster: [SimpleJob]
    var job_as_receiver: [SimpleJob]
    var job_as_potential: [SimpleJob]
    var rating_as_poster: [SimpleRating]
    var rating_as_postee: [SimpleRating]
    var chats: [SimpleChat]
    var messages: [MessageModal]
}
