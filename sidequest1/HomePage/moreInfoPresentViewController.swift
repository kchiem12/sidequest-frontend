//
//  moreInfoPresentViewController.swift
//  SideQuest
//
//  Created by Jesse Cheng on 11/25/22.
//

import UIKit

class moreInfoPresentViewController: UIViewController {
    
    
    var posting: Posting
    
    var gigName = UILabel()
    var gigAmount = UILabel()
    var profilePic = UIImageView()
    var profileName = UILabel()
    var gigDescription = UILabel()
    var category = UILabel()
    var relevantSkills = UILabel()
    var otherNotes = UILabel()
    var contactButton = UIButton()
    var interestButton = UIButton()
    var user: User
    
   
    init(posting: Posting, user: User) {
        self.posting = posting
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        createView()
        
        gigName.text = posting.gigName
        gigName.textColor = UIColor(red: 0.49, green: 0.569, blue: 0.773, alpha: 1)
        gigName.font = .systemFont(ofSize: 24, weight: .medium)
        view.addSubview(gigName)
        
        gigAmount.text = "$" + posting.gigAmount
        gigAmount.textColor = UIColor(red: 0.49, green: 0.569, blue: 0.773, alpha: 1)
        gigAmount.font = .systemFont(ofSize: 24, weight: .medium)
        view.addSubview(gigAmount)

        
        if (posting.profilePic.contains("http")) {
//            profilePic.setImageFromStringrlL(url: posting.profilePic)
            ImageProvider.sharedCache.getImage(url: posting.profilePic) { [weak self] image in
                self?.profilePic.image = image
            }
        } else {
            profilePic.image = UIImage(named: posting.profilePic)
        }
//        profilePic.image = UIImage(named: posting.profilePic)
        profilePic.layer.cornerRadius = 15
        profilePic.layer.masksToBounds = true
        view.addSubview(profilePic)
        
        profileName.text = posting.profileName
        profileName.textColor = UIColor(red: 0.263, green: 0.357, blue: 0.6, alpha: 1)
        profileName.font = .systemFont(ofSize: 20)
        view.addSubview(profileName)
        
        gigDescription.text = "Gig: \(posting.gigDescription)"
        gigDescription.textColor = UIColor(red: 0.49, green: 0.569, blue: 0.773, alpha: 1)
        gigDescription.font = .systemFont(ofSize: 20)
        gigDescription.numberOfLines = 0
        gigDescription.lineBreakMode = .byWordWrapping
        view.addSubview(gigDescription)
        
        category.text = "Category: \(posting.categoryName)"
        category.textColor = UIColor(red: 0.49, green: 0.569, blue: 0.773, alpha: 1)
        category.font = .systemFont(ofSize: 20)
        view.addSubview(category)

        relevantSkills.text = "Relevant Skills: \(posting.relevantSkills)"
        relevantSkills.textColor = UIColor(red: 0.49, green: 0.569, blue: 0.773, alpha: 1)
        relevantSkills.font = .systemFont(ofSize: 20)
        view.addSubview(relevantSkills)
        
        otherNotes.text = "Other Notes: \(posting.otherNotes)"
        otherNotes.textColor = UIColor(red: 0.49, green: 0.569, blue: 0.773, alpha: 1)
        otherNotes.font = .systemFont(ofSize: 20)
        view.addSubview(otherNotes)
        
        contactButton.setTitle("Contact (\(posting.profileName))", for: .normal)
        contactButton.layer.backgroundColor = UIColor(red: 0.847, green: 0.875, blue: 0.949, alpha: 1).cgColor
        contactButton.layer.cornerRadius = 8
        contactButton.setTitleColor(UIColor(red: 0.106, green: 0.192, blue: 0.408, alpha: 1), for: .normal)
//        contactButton.addTarget(self, action: nil, for: .touchUpInside)
        view.addSubview(contactButton)
        
        interestButton.setTitle("I'm Interested", for: .normal)
        interestButton.layer.backgroundColor = UIColor(rgb: 0xD8DFF2).cgColor
        interestButton.titleLabel?.textColor = UIColor(rgb: 0x1B3168)
        interestButton.layer.cornerRadius = 8
        interestButton.setTitleColor(UIColor(red: 0.106, green: 0.192, blue: 0.408, alpha: 1), for: .normal)
        interestButton.addTarget(self, action: #selector(interestAction), for: .touchUpInside)
        view.addSubview(interestButton)
        
        gigName.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(self.view.snp.top).offset(177)
            make.left.equalTo(self.view.snp.left).offset(25)
            make.right.equalTo(self.view.snp.right).offset(-150)
        }
        
        gigAmount.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(gigName.snp.top)
            make.left.equalTo(gigName.snp.right).offset(25)
            make.right.equalTo(self.view.snp.right).offset(-25)
        }

        profilePic.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(30)
            make.width.equalTo(30)
            make.top.equalTo(218)
            make.left.equalTo(gigName.snp.left)
        }

        profileName.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(profilePic.snp.right).offset(10)
            make.centerY.equalTo(profilePic.snp.centerY)
        }
        
        gigDescription.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(265)
            make.left.equalTo(gigName.snp.left)
            make.right.equalTo(self.view.snp.right).offset(-25)
        }
        
        category.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(330)
            make.left.equalTo(gigName.snp.left)
            make.right.equalTo(self.view.snp.right).offset(-25)
        }
        
        relevantSkills.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(380)
            make.left.equalTo(gigName.snp.left)
            make.right.equalTo(self.view.snp.right).offset(-25)
        }
        
        otherNotes.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(430)
            make.left.equalTo(gigName.snp.left)
            make.right.equalTo(self.view.snp.right).offset(-25)
        }
        
        interestButton.snp.makeConstraints { make in
            make.top.equalTo(otherNotes.snp.bottom).offset(20)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(336)
        }
        
        contactButton.snp.makeConstraints{(make) -> Void in
            make.width.equalTo(336)
            make.height.equalTo(60)
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.snp.bottom).offset(-50)
        }
    }
    
    @objc func interestAction() {
        
        NetworkManager.interestInJob(userID: user.id, jobID: posting.job!.id) { success in
            if success {
                print("bet")
            } else {
                print("doesn't work")
            }
        }
        
    }
    
    func createView() {
        let newView = UIView(frame: CGRect(x: 0, y: 150, width: view.frame.width, height: 630))
        newView.layer.cornerRadius = 16
        newView.backgroundColor = .white
        view.addSubview(newView)
        
        
    }

}

