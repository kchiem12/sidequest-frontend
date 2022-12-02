//
//  ChatModal.swift
//  sidequest1
//
//  Created by Ken Chiem on 12/2/22.
//

import UIKit
import Foundation

class ChatModal: Codable {
    var id: Int
    var message: [MessageModal]
    var users: [SimpleUser]
    var time: String
}
