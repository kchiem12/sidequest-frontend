//
//  MessageTableViewCell.swift
//  sidequest1
//
//  Created by Ken Chiem on 11/29/22.
//

import UIKit
import SnapKit

class MessageTableViewCell: UITableViewCell {

    let profileImageView: UIImageView = UIImageView()
    let nameLabel: UILabel = UILabel()
    let dateLabel: UILabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        // everything here is laid our correctly!!
//        contentView.backgroundColor = .systemRed
        
        nameLabel.text = "bruh moment"
        nameLabel.font = UIFont(name: "Merriweather-Regular", size: 20)
        nameLabel.textColor = UIColor(rgb: 0x435B99)
        contentView.addSubview(nameLabel)
        
        dateLabel.text = "10/5/2024"
        dateLabel.font = UIFont(name: "Merriweather-Regular", size: 18)
        dateLabel.textColor = UIColor(rgb: 0x7D91C5)
        contentView.addSubview(dateLabel)
        
        profileImageView.image = UIImage(named: "profile_placeholder")
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 32
        contentView.addSubview(profileImageView)
        
        setupConstraints()
        
    }
    
    func setupConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left).offset(17)
            make.centerY.equalTo(contentView.snp.centerY)
            make.height.equalTo(64)
            make.width.equalTo(64)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(profileImageView.snp.right).offset(15)
            make.top.equalTo(contentView.snp.top).offset(30)
            make.width.equalTo(275)
            make.height.equalTo(24)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel.snp.left)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
            make.width.equalTo(275)
            make.height.equalTo(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(user: User) {
        nameLabel.text = user.first + " " + user.last
        profileImageView.setImageFromStringrlL(url: user.assets[0].url!)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
