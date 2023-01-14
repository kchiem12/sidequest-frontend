//
//  UserInterestedTableViewCell.swift
//  sidequest1
//
//  Created by Jesse Cheng on 1/13/23.
//

import UIKit

class UserInterestedTableViewCell: UITableViewCell {
    
    let userImage = UIImageView()
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


        
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraints() {
        userDetail.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView.snp.top)
            make.left.equalTo(contentView.snp.left).offset(18)
        }
        
        userRating.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(userDetail.snp.bottom).offset(2)
            make.left.equalTo(contentView.snp.left).offset(18)
        }
        
    }
    
    func configure(user: User) {
        //figure out later
//        userImage.setImageFromStringrlL(url: user.assets[0].url!)
        
        let indexEndOfText = user.last.index(user.last.startIndex, offsetBy: 1)
        let newStr = String(user.last[..<indexEndOfText])
        userDetail.text = "\(user.first) \(newStr). interested in gig"
    }

}