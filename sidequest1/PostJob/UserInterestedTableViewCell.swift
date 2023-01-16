//
//  UserInterestedTableViewCell.swift
//  sidequest1
//
//  Created by Jesse Cheng on 1/13/23.
//

import UIKit

class UserInterestedTableViewCell: UITableViewCell {
    
    let userImageView = UIImageView()
    let userDetail = UILabel()
    let userRating = UILabel()
    let messageButton = UIButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        userDetail.textColor = UIColor(red: 0.49, green: 0.569, blue: 0.773, alpha: 1)
        userDetail.font = UIFont(name: "IBMPlexSans-Regular", size: 20)
        contentView.addSubview(userDetail)
        
        userRating.text = "Rating: X/5"
        userRating.textColor = UIColor(red: 0.49, green: 0.569, blue: 0.773, alpha: 1)
        userRating.font = UIFont(name: "IBMPlexSans-Regular", size: 20)
        contentView.addSubview(userRating)
        
        messageButton.setTitle("Message", for: .normal)
        messageButton.titleLabel?.font = UIFont(name: "IBMPlexSans-Regular", size: 16)
        messageButton.layer.cornerRadius = 8
        messageButton.layer.backgroundColor = UIColor(red: 0.49, green: 0.569, blue: 0.773, alpha: 1).cgColor
        contentView.addSubview(messageButton)
        
        userImageView.contentMode = .scaleAspectFill
        userImageView.clipsToBounds = true
        userImageView.layer.cornerRadius = 32
        contentView.addSubview(userImageView)

        
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraints() {
        userImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView.snp.top).offset(21)
            make.left.equalTo(contentView.snp.left).offset(20)
            make.height.equalTo(64)
            make.width.equalTo(64)
        }
        
        userDetail.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(userImageView.snp.top).offset(8)
            make.left.equalTo(userImageView.snp.right).offset(12)
        }
        
        userRating.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(userDetail.snp.bottom).offset(-2)
            make.left.equalTo(userImageView.snp.right).offset(12)
        }
        
        messageButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(userDetail.snp.bottom).offset(15)
            make.left.equalTo(userRating.snp.right).offset(77)
            make.width.equalTo(94)
            make.height.equalTo(30)
            make.bottom.equalTo(contentView.snp.bottom).offset(-13)
        }
        
    }
    
    func configure(user: User) {
        //figure out later
//        userImage.setImageFromStringrlL(url: user.assets[0].url!)
        
        let indexEndOfText = user.last.index(user.last.startIndex, offsetBy: 1)
        let newStr = String(user.last[..<indexEndOfText])
        userDetail.text = "\(user.first) \(newStr). interested in gig"
        
        if (user.assets.count == 0) {
            userImageView.image = UIImage(named: "profile_placeholder")
        }
        else {
            ImageProvider.sharedCache.getImage(url: user.assets[0].url!) { [weak self] image in
                DispatchQueue.main.async {
                    self?.userImageView.image = image
                }
            }
        }
    }

}
