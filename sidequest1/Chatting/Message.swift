//
//  Message.swift
//  sidequest1
//
//  Created by Ken Chiem on 11/28/22.
//

import UIKit
import MessageKit

// Structure of a message
struct Message {
    var id: String
    var content: String
    var senderName: String
    var senderID: String
    var created: Date
    var dictionary: [String: Any] {
        return [
            "id": id,
            "content": content,
            "created": created,
            "senderID": senderID,
            "senderName": senderName
        ]
    }
}

extension Message {
    init?(dictionary: [String: Any]) {
        guard let id = dictionary["id"] as? String,
              let content = dictionary["content"] as? String,
              let created = dictionary["created"] as? Date,
              let senderID = dictionary["senderID"] as? String,
              let senderName = dictionary["senderName"] as? String
        else {return nil}
        self.init(id: id, content: content, senderName: senderName, senderID: senderID, created: created)
    }
}

extension Message: MessageType {
    var sender: MessageKit.SenderType {
        return ChatUser(senderId: senderID, displayName: senderName)
    }

    var messageId: String {
        return id
    }

    var sentDate: Date {
        return created
    }

    var kind: MessageKit.MessageKind {
        return .text(content)
    }
}

