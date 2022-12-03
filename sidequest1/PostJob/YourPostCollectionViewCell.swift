//
//  YourPostCollectionViewCell.swift
//  sidequest1
//
//  Created by Ken Chiem on 12/2/22.
//

import UIKit

class YourPostCollectionViewCell: UICollectionViewCell {
    
    // Set Up Variables
    var gigName = UILabel()
    var gigAmount = UILabel()
    var datePosted = UILabel()
    var editButton = UIButton()
    var interactionButton = UIButton()
    var archiveButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Set up Properties
        gigName.textColor = UIColor(red: 0.431, green: 0.729, blue: 0.729, alpha: 1)
        gigName.font = UIFont(name: "Merriweather-Regular", size: 24)
        contentView.addSubview(gigName)
        
        gigAmount.textColor = UIColor(red: 0.431, green: 0.729, blue: 0.729, alpha: 1)
        gigAmount.font = UIFont(name: "Merriweather-Regular", size: 24)
        contentView.addSubview(gigAmount)
        
        datePosted.textColor = UIColor(red: 0.431, green: 0.729, blue: 0.729, alpha: 1)
        datePosted.font = UIFont(name: "IBMPlexSans-Regular", size: 20)
        contentView.addSubview(datePosted)
        
        editButton.setTitle("Edit", for: .normal)
        editButton.titleLabel?.font = UIFont(name: "Merriweather-Regular", size: 24)
        editButton.layer.backgroundColor = UIColor(red: 0.431, green: 0.729, blue: 0.729, alpha: 1).cgColor
        editButton.layer.cornerRadius = 16
        contentView.addSubview(editButton)
        
        interactionButton.setTitle("View Interactions", for: .normal)
        interactionButton.titleLabel?.font = UIFont(name: "Merriweather-Regular", size: 24)
        interactionButton.layer.backgroundColor = UIColor(red: 0.431, green: 0.729, blue: 0.729, alpha: 1).cgColor
        interactionButton.layer.cornerRadius = 16
        contentView.addSubview(interactionButton)
        
        archiveButton.setTitle("Archive", for: .normal)
        archiveButton.titleLabel?.font = UIFont(name: "Merriweather-Regular", size: 24)
        archiveButton.layer.backgroundColor = UIColor(red: 0.431, green: 0.729, blue: 0.729, alpha: 1).cgColor
        archiveButton.layer.cornerRadius = 16
        contentView.addSubview(archiveButton)
        
        // Set Up Constraints
        gigName.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView.snp.top).offset(18)
            make.left.equalTo(contentView.snp.left).offset(18)
        }
        
        gigAmount.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView.snp.top).offset(18)
            make.right.equalTo(contentView.snp.right).offset(-18)
        }
        
        datePosted.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(gigName.snp.bottom).offset(10)
            make.left.equalTo(contentView.snp.left).offset(18)
        }
        
        editButton.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(336)
            make.height.equalTo(60)
            make.top.equalTo(datePosted.snp.bottom).offset(11)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        
        interactionButton.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(336)
            make.height.equalTo(60)
            make.top.equalTo(editButton.snp.bottom).offset(12)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        
        archiveButton.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(336)
            make.height.equalTo(60)
            make.top.equalTo(interactionButton.snp.bottom).offset(12)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        
        
    }
    
    func configure(job: Job) {
        gigName.text = job.title
        let indexEndOfText = job.date_created.index(job.date_created.endIndex, offsetBy: -16)
        let newStr = String(job.date_created[..<indexEndOfText])
        datePosted.text = "Date Posted: \(newStr)"
        gigAmount.text = "$\(job.reward)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
