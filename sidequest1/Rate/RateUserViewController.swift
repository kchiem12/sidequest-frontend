//
//  RateUserViewController.swift
//  sidequest1
//
//  Created by Ken Chiem on 1/23/23.
//

import UIKit
import SnapKit

class RateUserViewController: UIViewController {
    
    let gigNameLabel: UILabel = UILabel()
    let dateCompletedLabel: UILabel = UILabel()
    let rewardLabel: UILabel = UILabel()
    let rateUserPerformanceLabel: UILabel = UILabel()
    let ratingSlider: UISlider = UISlider()
    let minimumValueLabel: UILabel = UILabel()
    let maximumValueLabel: UILabel = UILabel()
    let unsatisfactoryLabel: UILabel = UILabel()
    let satisfactoryLabel: UILabel = UILabel()
    var gig: Job?
    
    init(gig: Job?) {
        self.gig = gig
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(rgb: 0xFFFFFF)
        
        ratingSlider.minimumValue = 0
        ratingSlider.maximumValue = 5
        ratingSlider.isContinuous = false
        ratingSlider.maximumTrackTintColor = UIColor(rgb: 0x7D91C5)
        ratingSlider.minimumTrackTintColor = UIColor(rgb: 0x435B99)
        ratingSlider.thumbTintColor = UIColor(rgb: 0x435B99)
        view.addSubview(ratingSlider)
        
        gigNameLabel.text = "placeholder"
        gigNameLabel.font = UIFont(name: "IBMPlexSans-Regular", size: 31)
        gigNameLabel.textColor = UIColor(rgb: 0x7D91C5)
        view.addSubview(gigNameLabel)
        
        dateCompletedLabel.text = "date completed label"
        dateCompletedLabel.font = UIFont(name: "IBMPlexSans-Regular", size: 20)
        dateCompletedLabel.textColor = UIColor(rgb: 0x435B99)
        view.addSubview(dateCompletedLabel)
        
        
        if let reward = gig?.reward {
            rewardLabel.text = "$\(reward)"
        } else {
            rewardLabel.text = "$??"
        }
        rewardLabel.font = UIFont(name: "IBMPlexSans-Regular", size: 24)
        rewardLabel.textColor = UIColor(rgb: 0x7D91C5)
        view.addSubview(rewardLabel)
        
        if let firstName = (gig?.receiver[0].first) {
            rateUserPerformanceLabel.text = "Rate \(firstName)'s performance"
        } else {
            rateUserPerformanceLabel.text = "Rate User's performance"
        }
        rateUserPerformanceLabel.font = UIFont(name: "IBMPlexSans-Regular", size: 20)
        rateUserPerformanceLabel.textColor = UIColor(rgb: 0x435B99)
        view.addSubview(rateUserPerformanceLabel)
        
        minimumValueLabel.text = "0"
//        minimumValueLabel.font = UIFont(name: "IBMPlexSans-Regular", size: <#T##CGFloat#>)
        
        setConstraints()
    }
    
    func setConstraints() {
        ratingSlider.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(175)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-25)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(25)
            make.height.equalTo(50)
        }
        
        gigNameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(0)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(28)
        }
        
        dateCompletedLabel.snp.makeConstraints { make in
            make.top.equalTo(gigNameLabel.snp.bottom).offset(5)
            make.left.equalTo(gigNameLabel.snp.left)
        }
    }

    
    
}
