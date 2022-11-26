//
//  ChatViewController.swift
//  sidequest1
//
//  Created by Ken Chiem on 11/26/22.
//

import UIKit
import SnapKit
import MessageKit

struct Sender: SenderType {
    var senderId: String
    
    var displayName: String
    
    
}

struct Message: MessageType {
    var sender: MessageKit.SenderType
    
    var messageId: String
    
    var sentDate: Date
    
    var kind: MessageKit.MessageKind
    
    
}

class ChatViewController: MessagesViewController {
    
    let currUser: Sender = Sender(senderId: "self", displayName: "Ken")
    let otherUser: Sender = Sender(senderId: "other", displayName: "Jack")
    
    var message = [MessageType]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        
        message.append(Message(sender: currUser,
                               messageId: "1",
                               sentDate: Date().addingTimeInterval(-86400),
                               kind: .text("Hello!!")))
        message.append(Message(sender: otherUser,
                               messageId: "2",
                               sentDate: Date().addingTimeInterval(-86350),
                               kind: .text("bithc")))
        message.append(Message(sender: currUser,
                               messageId: "3",
                               sentDate: Date().addingTimeInterval(-85000),
                               kind: .text("no u")))
        
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesDisplayDelegate = self
        view.addSubview(messagesCollectionView)
        
        
    }

}

extension ChatViewController: MessagesDataSource {
    func currentSender() -> MessageKit.SenderType {
        return currUser
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> MessageKit.MessageType {
        return message[indexPath.section]  // use sections instead of rows (as seen below)
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        message.count
    }
    
    
}

extension ChatViewController: MessagesLayoutDelegate {
    
}

extension ChatViewController: MessagesDisplayDelegate {
    
}
