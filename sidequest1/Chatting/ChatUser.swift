//
//  ChatUser.swift
//  sidequest1
//
//  Created by Ken Chiem on 11/28/22.
//

import UIKit
import MessageKit

struct ChatUser: SenderType, Equatable {
    var senderId: String
    var displayName: String
}
