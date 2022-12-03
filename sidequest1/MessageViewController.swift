//
//  MessageViewController.swift
//  sidequest1
//
//  Created by Ken Chiem on 11/26/22.
//

import UIKit
import SnapKit

class MessageViewController: UIViewController, UITableViewDelegate {
    
    // Change it later to incorporate users
    let messages = UITableView()
    let messageReuseIdentifier: String = "messageReuseIdentifier"
    let gradient: CAGradientLayer = CAGradientLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add gradient background
        gradient.frame = self.view.bounds
        gradient.colors = [
            UIColor(rgb: 0xD8DFF2).cgColor, UIColor(rgb: 0xE1F8F8).cgColor
        ]
        gradient.startPoint = CGPoint.zero
        gradient.endPoint = CGPoint(x: 1, y: 1)
        self.view.layer.insertSublayer(gradient, at: 0)
        
        messages.register(MessageTableViewCell.self, forCellReuseIdentifier: messageReuseIdentifier)
        messages.delegate = self
        messages.rowHeight = 100
        messages.dataSource = self
        messages.backgroundColor = .clear
        view.addSubview(messages)
        
        setupConstraints()
    }

    func setupConstraints() {
        messages.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    // To push the chat view controller over
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatVC = ChatViewController(user: nil)
        chatVC.title = "Messages"
        navigationController?.pushViewController(chatVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MessageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: messageReuseIdentifier, for: indexPath) as? MessageTableViewCell {
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
//
//extension MessageViewController: UITableViewDelegate {
//}
