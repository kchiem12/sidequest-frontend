//
//  Account.swift
//  sidequest1
//
//  Created by Ken Chiem on 11/26/22.
//

import Foundation

// The structure of an account
// TODO: add a variable for images
struct Profile: Codable {
    let id: String
    let email: String
    let firstName: String
    let lastName: String
    let phoneNumber: String
}
