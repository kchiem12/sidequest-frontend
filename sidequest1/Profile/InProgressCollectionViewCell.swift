//
//  InProgressCollectionViewCell.swift
//  sidequest1
//
//  Created by Ken Chiem on 11/30/22.
//

import UIKit

class InProgressCollectionViewCell: UICollectionViewCell {
    // Set Up Variables
    var gigName = UILabel()
    var gigAmount = UILabel()
    var profilePic = UIImageView()
    var profileName = UILabel()
    var gigDescription = UILabel()
    var completedButton = UIButton()
    var indexOfCell: Int = 0
    var job: Job?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Set Up Properties
        gigName.textColor = UIColor(red: 0.49, green: 0.569, blue: 0.773, alpha: 1)
        gigName.font = .systemFont(ofSize: 24, weight: .medium)
        contentView.addSubview(gigName)
        
        gigAmount.textColor = UIColor(red: 0.49, green: 0.569, blue: 0.773, alpha: 1)
        gigAmount.font = .systemFont(ofSize: 24, weight: .medium)
        contentView.addSubview(gigAmount)
        
        
        profilePic.layer.cornerRadius = 15
        profilePic.layer.masksToBounds = true
        contentView.addSubview(profilePic)
        
        profileName.textColor = UIColor(red: 0.263, green: 0.357, blue: 0.6, alpha: 1)
        profileName.font = .systemFont(ofSize: 20)
        contentView.addSubview(profileName)
        
        gigDescription.textColor = UIColor(red: 0.49, green: 0.569, blue: 0.773, alpha: 1)
        gigDescription.font = .systemFont(ofSize: 20)
        gigDescription.numberOfLines = 0
        gigDescription.lineBreakMode = .byWordWrapping
        contentView.addSubview(gigDescription)
        
        completedButton.setTitle("Mark as Completed", for: .normal)
        completedButton.titleLabel?.font = UIFont(name: "Merriweather-Regular", size: 24)
        completedButton.isUserInteractionEnabled = true
        completedButton.setTitleColor(UIColor(rgb: 0x8A9CCB), for: .normal)
        completedButton.layer.borderWidth = 2
        completedButton.layer.borderColor = UIColor(rgb: 0x8A9CCB).cgColor
        completedButton.addTarget(self, action: #selector(completeJob), for: .touchUpInside)
        completedButton.layer.cornerRadius = 16
        completedButton.backgroundColor = .clear
        contentView.addSubview(completedButton)
        
        // Set Up Constraints
        
        gigName.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(self.contentView.snp.top).offset(14)
            make.left.equalTo(self.contentView.snp.left).offset(15)
            make.right.equalTo(self.contentView.snp.right).offset(-122)
        }
        
        gigAmount.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(gigName.snp.top)
            make.left.equalTo(gigName.snp.right).offset(26)
            make.right.equalTo(self.contentView.snp.right).offset(-15)
        }

        profilePic.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(30)
            make.width.equalTo(30)
            make.top.equalTo(54)
            make.left.equalTo(gigName.snp.left)
        }

        profileName.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(profilePic.snp.right).offset(10)
            make.centerY.equalTo(profilePic.snp.centerY)
        }

        gigDescription.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(86)
            make.left.equalTo(gigName.snp.left)
            make.right.equalTo(self.contentView.snp.right).offset(-15)
//            make.bottom.equalTo(self.contentView.snp.bottom).offset(-5)
        }
        
        completedButton.snp.makeConstraints { make in
            make.top.equalTo(gigDescription.snp.bottom).offset(20)
            make.right.equalTo(self.contentView.snp.right).offset(-15)
            make.left.equalTo(self.contentView.snp.left).offset(15)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-8)
        }
    }

    @objc func completeJob() {
        guard let job = self.job else {
            return
        }
    }
    
    func configure(posting: Posting, index: Int){
        indexOfCell = index
        gigName.text = posting.gigName
        gigAmount.text = "$" + posting.gigAmount
        if (posting.profilePic.contains("http")) {
//            profilePic.setImageFromStringrlL(url: posting.profilePic)
            ImageProvider.sharedCache.getImage(url: posting.profilePic) { [weak self] image in
                self?.profilePic.image = image
            }
        } else {
            profilePic.image = UIImage(named: posting.profilePic)
        }
        profileName.text = posting.profileName
        gigDescription.text = "Gig: \(posting.gigDescription)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
