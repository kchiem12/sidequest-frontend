//
//  ChatViewController.swift
//  sidequest1
//
//  Created by Ken Chiem on 11/26/22.
//

import UIKit
import SnapKit
import MessageKit
import InputBarAccessoryView
import SocketIO


// Source from https://ibjects.medium.com/simple-text-chat-app-using-firebase-in-swift-5-b9fa91730b6c

//InputBarAccessoryViewDelegate, MessagesDataSource

class ChatViewController: MessagesViewController, MessagesLayoutDelegate, MessagesDisplayDelegate {

    // Variables needed for messaging
    var currUser: User?
    var messages: [Message] = []
    var otherUserName: String?
    var otherUserImgUrl: String?
    var otherUserID: String? // Maybe change the ID to an Int??
    let socketConnection = SocketConnection()
    var newChatBool: Bool = false

    init(user: User?) {
        self.currUser = user
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        
        addHandlers()
        socketConnection.socket.connect()

        messagesCollectionView.messagesLayoutDelegate = self
//        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
        view.addSubview(messagesCollectionView)


    }

    // make it so keyboard appears before everything
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        messageInputBar.inputTextView.becomeFirstResponder()
    }
    
    func addHandlers() {
        socketConnection.socket.on(clientEvent: .connect) { data, ack in
            print("--------------------------------------SOCKET IS CONNECTED!!!---------------------------------------------------------")
            self.socketConnection.manager.defaultSocket.emit("connect", ["user1_id": 0, "user2_id": 1, "chat_id": 0])
//            self.socketConnection.socket.disconnect()
        }
        
        socketConnection.socket.on("past_history") { data, ack in
            print("recieved request----------------AHAHAHAAHAHAAHAHAHAHAHAHAHAHAHAHHAAHHAHAHAHAHAHAHAHAHAAHAHAHHAHA")
        }
        
        
    }
    
    func loadChat() {
        
    }

}

// singleton class for socket
open class SocketConnection {
    public static let defaultSocket = SocketConnection()
    let manager: SocketManager
    var socket: SocketIOClient

    init() {
        manager = SocketManager(socketURL: URL(string: "ws://34.85.181.121")!, config: [.log(true), .compress])
        socket = manager.socket(forNamespace: "/api/chat/")
    }
}
    
extension ChatViewController: InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        guard !text.replacingOccurrences(of: " ", with: "").isEmpty else {
            return
        }

        print("Message \(text)")

        // send message
        // if isNewConversation {
        // create convo in database
        // else
        // append to existing conversation


    }
}
