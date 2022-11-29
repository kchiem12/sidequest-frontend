//
//  Chat.swift
//  sidequest1
//
//  Created by Ken Chiem on 11/28/22.
//

import Foundation
import UIKit

// Structure of a Chat
struct Chat {
    var users: [String]
    var dictionary: [String: Any] {
        return ["users": users]
    }
}

extension Chat {
    init?(dictionary: [String: Any]) {
        guard let chatUsers = dictionary["users"] as? [String] else {
            return nil
        }
        self.init(users: chatUsers)
    }
}
