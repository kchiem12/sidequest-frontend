//
//  ViewInteractionsViewController.swift
//  sidequest1
//
//  Created by Jesse Cheng on 1/13/23.
//

import UIKit
import SnapKit

class ViewInteractionsViewController: UIViewController, UITableViewDelegate {
    
    //  Set Up Variables
    var job: Job
    
    // MARK: UI Elements
    var gigName = UILabel()
    
    let userInterestedTableView = UITableView()
    let reuseIdentifier = "reuseIdentifier"
    
    // MARK: Data
    var usersData: [User] = []
    var shownUsersData: [User] = []
    
    
    init(job: Job) {
        self.job = job
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        gigName.text = job.title
        gigName.textColor = UIColor(red: 0.49, green: 0.569, blue: 0.773, alpha: 1)
        gigName.font = UIFont(name: "IBMPlexSans-Thin", size: 32)
        view.addSubview(gigName)
        
        //MARK: Initialize TableView
        userInterestedTableView.delegate = self
        userInterestedTableView.dataSource = self
        userInterestedTableView.register(UserInterestedTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(userInterestedTableView)
        
        getUsersInterested()
        
        setUpConstraints()
    }
    
    // network request to get users that have shown interest in job
    func getUsersInterested() {
        var usersData: [User] = []
        
        for user in job.potential {
            NetworkManager.getSpecificUser(userID: user.id!) { user in
                usersData.append(user)
                self.usersData = usersData
                self.shownUsersData = self.usersData
                self.userInterestedTableView.reloadData()
            }
        }
    }
    
    func setUpConstraints() {
        gigName.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.snp.top).offset(18)
            make.left.equalTo(view.snp.left).offset(18)
        }
        
        userInterestedTableView.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(gigName.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(view.snp.bottom)
        }
    }

}

extension ViewInteractionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownUsersData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = userInterestedTableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? UserInterestedTableViewCell{
            cell.configure(user: shownUsersData[indexPath.row])
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108.0
    }
}
