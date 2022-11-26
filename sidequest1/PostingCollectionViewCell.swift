//
//  PostingCollectionViewCell.swift
//  SideQuest
//
//  Created by Jesse Cheng on 11/24/22.
//

import UIKit

class PostingCollectionViewCell: UICollectionViewCell {
    
    // Set Up Variables
    var gigName = UILabel()
    var gigAmount = UILabel()
    var profilePic = UIImageView()
    var profileName = UILabel()
    var gigDescription = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Set Up Properties
        gigName.textColor = UIColor(red: 0.49, green: 0.569, blue: 0.773, alpha: 1)
        gigName.font = .systemFont(ofSize: 23, weight: .medium)
        contentView.addSubview(gigName)
        
        gigAmount.textColor = UIColor(red: 0.49, green: 0.569, blue: 0.773, alpha: 1)
        gigAmount.font = .systemFont(ofSize: 23, weight: .medium)
        contentView.addSubview(gigAmount)
        
        profilePic.layer.cornerRadius = 21
        profilePic.layer.masksToBounds = true
        contentView.addSubview(profilePic)
        
        profileName.textColor = UIColor(red: 0.263, green: 0.357, blue: 0.6, alpha: 1)
        profileName.font = .systemFont(ofSize: 17)
        contentView.addSubview(profileName)
        
        gigDescription.textColor = UIColor(red: 0.49, green: 0.569, blue: 0.773, alpha: 1)
        gigDescription.font = .systemFont(ofSize: 17)
        gigDescription.numberOfLines = 0
        gigDescription.lineBreakMode = .byWordWrapping
        contentView.addSubview(gigDescription)
        
        // Set Up Constraints
        
        gigName.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(contentView.self).offset(-115)
            make.left.equalTo(contentView.self).offset(15)
            make.right.equalTo(contentView.self).offset(-120)
            make.bottom.equalTo(contentView.self)
        }
        
        gigAmount.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(gigName.snp.top)
            make.left.equalTo(gigName.snp.right).offset(40)
            make.right.equalTo(contentView.self).offset(-15)
            make.bottom.equalTo(contentView.self)
        }

        profilePic.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(42)
            make.width.equalTo(42)
            make.top.equalTo(50)
            make.left.equalTo(gigName.snp.left)
        }

        profileName.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(profilePic.snp.right).offset(10)
            make.top.equalTo(profilePic.snp.top).offset(9)
        }

        gigDescription.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(85)
            make.left.equalTo(gigName.snp.left)
            make.right.equalTo(contentView.self).offset(-15)
            make.bottom.equalTo(contentView.self).offset(-5)
        }
    }
//
    func configure(posting: Posting){
        gigName.text = posting.gigName
        gigAmount.text = "$\(posting.gigAmount)"
        profilePic.image = UIImage(named: posting.profilePic)
        profileName.text = posting.profileName
        gigDescription.text = "Gig: \(posting.gigDescription)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
