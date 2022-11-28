//
//  JobCollectionViewCell.swift
//  SideQuest
//
//  Created by Jesse Cheng on 11/21/22.
//

import UIKit
import SnapKit

class JobCollectionViewCell: UICollectionViewCell {
    
    var jobFilterLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.clipsToBounds = true
        
        jobFilterLabel.backgroundColor = .white
        jobFilterLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        jobFilterLabel.textAlignment = .center
        jobFilterLabel.textColor = UIColor(red: 0.106, green: 0.192, blue: 0.408, alpha: 1)
        jobFilterLabel.layer.cornerRadius = 13
        jobFilterLabel.layer.masksToBounds = true
        contentView.addSubview(jobFilterLabel)
        
        // Set Up Constraints
        jobFilterLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.contentView)
            make.left.equalTo(self.contentView)
            make.right.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView)
        }
    
    }
    
    func configure(job: Joba) {
        jobFilterLabel.text = "\(job.jobCategoryName)"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
