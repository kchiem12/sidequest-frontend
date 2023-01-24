//
//  SelectedUserTaskCollectionViewCell.swift
//  sidequest1
//
//  Created by Ken Chiem on 1/22/23.
//

import UIKit

class SelectedUserTaskCollectionViewCell: UICollectionViewCell {
    
    // Set Up Variables
    var gigName = UILabel()
    var gigAmount = UILabel()
    var datePosted = UILabel()
    var payButton = UIButton()
    var rateButton = UIButton()
    var archiveButton = UIButton()
    var job: Job?
    var index: Int = 0
    
    weak var editDelegate: EditPostDelegate?
    weak var rateDelegate: RateUserDelegate?
    
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
        
        payButton.setTitle("Pay QuestTaker", for: .normal)
        payButton.titleLabel?.font = UIFont(name: "Merriweather-Regular", size: 24)
        payButton.layer.backgroundColor = UIColor(red: 0.431, green: 0.729, blue: 0.729, alpha: 1).cgColor
        // figure out how to handle payment of questtaker later
//        payButton.addTarget(self, action: #selector(presentEditScreen), for: .touchUpInside)
        payButton.layer.cornerRadius = 16
        contentView.addSubview(payButton)
        
        rateButton.setTitle("Rate QuestTaker", for: .normal)
        rateButton.titleLabel?.font = UIFont(name: "Merriweather-Regular", size: 24)
        rateButton.layer.backgroundColor = UIColor(red: 0.431, green: 0.729, blue: 0.729, alpha: 1).cgColor
        rateButton.layer.cornerRadius = 16
        rateButton.addTarget(self, action: #selector(presentRateVC), for: .touchUpInside)
        contentView.addSubview(rateButton)
        
        archiveButton.setTitle("Archive", for: .normal)
        archiveButton.titleLabel?.font = UIFont(name: "Merriweather-Regular", size: 24)
        archiveButton.layer.backgroundColor = UIColor(red: 0.431, green: 0.729, blue: 0.729, alpha: 1).cgColor
        archiveButton.layer.cornerRadius = 16
        archiveButton.addTarget(self, action: #selector(archiveJob), for: .touchUpInside)
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
        
        payButton.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(336)
            make.height.equalTo(60)
            make.top.equalTo(datePosted.snp.bottom).offset(11)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        
        rateButton.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(336)
            make.height.equalTo(60)
            make.top.equalTo(payButton.snp.bottom).offset(12)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        
        archiveButton.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(336)
            make.height.equalTo(60)
            make.top.equalTo(rateButton.snp.bottom).offset(12)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        
        
    }
    
    // Presents the edit post view controller
    @objc func presentEditScreen() {
        editDelegate?.presentEditVC(job: self.job!)
    }
    
    @objc func archiveJob() {
                
        guard let jobId = job?.id else {
            print("Job ID doesn't exist")
            return
        }
        
        editDelegate?.deletePost(jobID: jobId, index: self.index)
    }
    
    @objc func presentRateVC() {
        guard let job = self.job else {
            print("No job found!")
            return
        }
        rateDelegate?.presentRateViewController(job: job)
    }
    
    func configure(job: Job, delegate1: EditPostDelegate, delegate2: RateUserDelegate, index: Int) {
        gigName.text = job.title
        self.index = index
        self.editDelegate = delegate1
        self.rateDelegate = delegate2
        self.job = job
        let indexEndOfText = job.date_created.index(job.date_created.endIndex, offsetBy: -16)
        let newStr = String(job.date_created[..<indexEndOfText])
        datePosted.text = "Date Posted: \(newStr)"
        if let reward = job.reward {
            gigAmount.text = "$\(reward)"
        } else {
            gigAmount.text = "No stated reward"
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol RateUserDelegate: UIViewController {
    func presentRateViewController(job: Job)
}
