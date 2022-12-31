//
//  FavoritesCollectionViewCell.swift
//  sidequest1
//
//  Created by Ken Chiem on 12/1/22.
//

import UIKit

class FavoritesCollectionViewCell: UICollectionViewCell {
    
    // Set Up Variables
    var gigName = UILabel()
    var gigAmount = UILabel()
    var profilePic = UIImageView()
    var profileName = UILabel()
    var gigDescription = UILabel()
    let star = UIImageView()
    var favorite = false
    
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
        
        star.image = UIImage(named: "unfavoritedStar")
        star.contentMode = .scaleAspectFill
        star.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(flipStar(gesture:))))
        star.isUserInteractionEnabled = true
        star.clipsToBounds = true
        
        contentView.addSubview(star)
        
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
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-5)
        }
        
        star.snp.makeConstraints { make in
            make.bottom.equalTo(gigDescription.snp.bottom)
            make.right.equalTo(self.contentView.snp.right).offset(-15)
            make.height.equalTo(33)
            make.width.equalTo(35)
        }
    }
    
    @objc func flipStar(gesture: UITapGestureRecognizer) {
        favorite = !favorite
        print("clicked on")
        if favorite {
            star.image = UIImage(named: "favoritedStar")
        } else {
            star.image = UIImage(named: "unfavoritedStar")
        }
    }
    
    func configure(posting: Posting){
        gigName.text = posting.gigName
        gigAmount.text = String(format: "$%.2f", posting.gigAmount)
        profilePic.image = UIImage(named: posting.profilePic)
        profileName.text = posting.profileName
        gigDescription.text = "Gig: \(posting.gigDescription)"
        if posting.favorite {
            star.image = UIImage(named: "favoritedStar")
            favorite = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
