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


// Source from https://ibjects.medium.com/simple-text-chat-app-using-firebase-in-swift-5-b9fa91730b6c

//InputBarAccessoryViewDelegate, MessagesDataSource

class ChatViewController: MessagesViewController, MessagesLayoutDelegate, MessagesDisplayDelegate, URLSessionWebSocketDelegate {

    // Creates a web socket
    private var webSocket: URLSessionWebSocketTask?

    // Variables needed for messaging
    var currUser: User?
    var messages: [Message] = []
    var otherUserName: String?
    var otherUserImgUrl: String?
    var otherUserID: String? // Maybe change the ID to an Int??

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

        let session = URLSession(
            configuration: .default,
            delegate: self,
            delegateQueue: OperationQueue()
        )
        let socketUrl = URL(string: "wss://demo.piesocket.com/v3/channel_123?api_key=VCXCEuvhGcBDP7XhiJJUDvR1e1D3eiVjgZ9VRiaV&notify_self")
        webSocket = session.webSocketTask(with: socketUrl!)
        webSocket?.resume()



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
    
    //
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        print("Established connection with socket")
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print("Closed connection")
    }
    
    // To check if websocket is still connected
    func ping() {
        webSocket?.sendPing { error in
            if let error = error {
                print("Ping error: \(error)")
            }
        }
    }
    
    func sendMessage() {
        
    }
    
    //
    func receiveMessage() {
        
    }
    
    // To close the connection
    func close() {
        webSocket?.cancel(with: .goingAway, reason: "Ended chat".data(using: .utf8))
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
