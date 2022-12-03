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

class ChatViewController: MessagesViewController, MessagesLayoutDelegate, MessagesDisplayDelegate, MessagesDataSource {
    
    func currentSender() -> SenderType {
        return Sender(senderId: "1", displayName: "matt")
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> MessageKit.MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        if messages.count == 0 {
            print("No messages to display on screen")
            return 0
        } else {
            return messages.count
        }
    }
    

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
    
    
    var message1 = Message(dictionary: ["id": "1", "content": "Hi! I am interested in this job", "created": Date(), "senderID": "1", "senderName": "matt"])
    var message2 = Message(dictionary: ["id": "2", "content": "Hello! Can you tell me a little about yourself?", "created": Date(), "senderID": "2", "senderName": "corbin"])



    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        
        title = "Matt"
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor(rgb: 0x435B99),
            .font: UIFont(name: "Merriweather-Regular", size: 20)
        ]
        
        messages = [message1!, message2!]
        
        addHandlers()
        socketConnection.socket.connect()

        messagesCollectionView.backgroundColor = UIColor(rgb: 0xE1F8F8)
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messagesCollectionViewFlowLayout.setMessageIncomingAvatarSize(.zero)
        messagesCollectionView.messagesCollectionViewFlowLayout.setMessageOutgoingAvatarSize(.zero)
        messageInputBar.delegate = self
        messageInputBar.sendButton.image = UIImage(named: "arrow")
        messageInputBar.sendButton.setTitle("", for: .normal)
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
            self.socketConnection.socket.emit("new_chat", ["sender_id": 100000000000, "receiver_id": 20000000000])
        }
        
        socketConnection.socket.on("connection succeeded") { data, ack in
            print("------------------------------------------------------------recieved request------------------------------------------------------------------------------------------------")
        }
        
        socketConnection.socket.on("private_message") { data, ack in
            print("private message was received!!!!!!!!!")
            
        }
        
        socketConnection.socket.on("failure") { data, ack in
            print("failed to send message")
        }
        
        
    }
    
    func loadChat() {
        
    }
    
    // function to insert a new message and display on collectionview
    func insertNewMessages(_ message: Message) {
        messages.append(message)
        messagesCollectionView.reloadData()
        
        socketConnection.socket.emit("private_message", ["sender_id": 100000000000, "receiver_id": 20000000000, "msg": "feiosfji"])
        
        DispatchQueue.main.async {
            self.messagesCollectionView.scrollToLastItem(at: .bottom, animated: true)
        }
    }
    
    
    // sets the layout of the messages
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        avatarView.isHidden = true
    }
    
    // sets the background color of the message bubble
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .white : .lightGray
    }
    
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return UIColor(rgb: 0x435B99)
    }
    
    // sets the message style
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        
        return .bubbleTail(corner, .curved)
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
        
        let message = Message(id: UUID().uuidString, content: text, senderName: "matt", senderID: "1", created: Date())

        insertNewMessages(message)
        
        inputBar.inputTextView.text = ""
        messagesCollectionView.reloadData()
        messagesCollectionView.scrollToLastItem(animated: true)

    }
}
