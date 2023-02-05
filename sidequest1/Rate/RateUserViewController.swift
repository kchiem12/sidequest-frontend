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
    let submitRatingButton: UIButton = UIButton()
    let ratingLabel: UILabel = UILabel()
    var gig: Job?
    
    init(gig: Job) {
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
        ratingSlider.isContinuous = true
        ratingSlider.maximumTrackTintColor = UIColor(rgb: 0x7D91C5)
        ratingSlider.minimumTrackTintColor = UIColor(rgb: 0x435B99)
        ratingSlider.thumbTintColor = UIColor(rgb: 0x435B99)
        ratingSlider.addTarget(self, action: #selector(updateRatingView), for: .valueChanged)
        view.addSubview(ratingSlider)
        
        gigNameLabel.text = "\(gig?.title ?? "Gig")"
        gigNameLabel.font = UIFont(name: "IBMPlexSans-Regular", size: 31)
        gigNameLabel.textColor = UIColor(rgb: 0x7D91C5)
        view.addSubview(gigNameLabel)
        
        dateCompletedLabel.text = "Completed"
        dateCompletedLabel.font = UIFont(name: "IBMPlexSans-Regular", size: 20)
        dateCompletedLabel.textColor = UIColor(rgb: 0x435B99)
        view.addSubview(dateCompletedLabel)
        
        rewardLabel.text = "$\(gig?.reward ?? "XX.XX")"
        rewardLabel.font = UIFont(name: "IBMPlexSans-Regular", size: 24)
        rewardLabel.textColor = UIColor(rgb: 0x7D91C5)
        view.addSubview(rewardLabel)
        
        rateUserPerformanceLabel.text = "Rate \(gig?.receiver[0].first ?? "User")'s Performance"
        rateUserPerformanceLabel.font = UIFont(name: "IBMPlexSans-Regular", size: 20)
        rateUserPerformanceLabel.textColor = UIColor(rgb: 0x435B99)
        view.addSubview(rateUserPerformanceLabel)
        
        minimumValueLabel.text = "0"
        minimumValueLabel.font = UIFont(name: "IBMPlexSans-Regular", size: 20)
        minimumValueLabel.textColor = UIColor(rgb: 0x435B99)
        view.addSubview(minimumValueLabel)
        
        maximumValueLabel.text = "5"
        maximumValueLabel.font = UIFont(name: "IBMPlexSans-Regular", size: 20)
        maximumValueLabel.textColor = UIColor(rgb: 0x435B99)
        view.addSubview(maximumValueLabel)
        
        unsatisfactoryLabel.text = "unsatisfactory"
        unsatisfactoryLabel.font = UIFont(name: "IBMPlexSans-Regular", size: 12)
        unsatisfactoryLabel.textColor = UIColor(rgb: 0x435B99)
        view.addSubview(unsatisfactoryLabel)
        
        satisfactoryLabel.text = "satisfactory"
        satisfactoryLabel.font = UIFont(name: "IBMPlexSans-Regular", size: 12)
        satisfactoryLabel.textColor = UIColor(rgb: 0x435B99)
        view.addSubview(satisfactoryLabel)
        
        submitRatingButton.setTitle("Submit Rating", for: .normal)
        submitRatingButton.titleLabel?.font = UIFont(name: "IBMPlexSans-Regular", size: 24)
        submitRatingButton.titleLabel?.textColor = UIColor(rgb: 0xD8DFF2)
        submitRatingButton.backgroundColor = UIColor(rgb: 0x435B99)
        submitRatingButton.layer.cornerRadius = 8
        submitRatingButton.addTarget(self, action: #selector(submitRating), for: .touchUpInside)
        view.addSubview(submitRatingButton)
        
        ratingLabel.text = "\(Int(ratingSlider.value)) / 5"
        ratingLabel.font = UIFont(name: "IBMPlexSans-Regular", size: 40)
        ratingLabel.textColor = UIColor(rgb: 0x435B99)
        view.addSubview(ratingLabel)
        
        setConstraints()
    }
    
    @objc func submitRating() {
        
        guard let theJob = gig else {
            return
        }
        
        if (theJob.longtitude != 0) {
            NetworkManager.editRating(job: theJob, rating: Int(ratingSlider.value), description: "", ratingId: theJob.longtitude) { success, error in
                if (success) {
                    self.dismiss(animated: true)
                } else {
                    print(error ?? "Error in updating rating for user")
                }
            }
        } else {
            NetworkManager.rateUser(job: theJob, rating: Int(ratingSlider.value), description: "") { success, error, rating in
                if (success) {
                    
                    guard let rate = rating else {
                        return
                    }
                    
                    NetworkManager.updateJob(jobId: theJob.id, title: theJob.title, description: theJob.description, location: theJob.location, date_activity: theJob.date_activity, duration: theJob.duration, reward: theJob.reward ?? "XX.XX", category: theJob.category, longtitude: rate.id, latitude: theJob.latitude, other_notes: theJob.other_notes, relevant_skills: theJob.relevant_skills) { success in
                        if (success) {
                            self.dismiss(animated: true)
                        } else {
                            print("Failed to update the user")
                        }
                    }
                } else {
                    print(error ?? "Error in creating rating for user")
                }
            }
        }
    }
    
    @objc func updateRatingView() {
        ratingLabel.text = "\(Int(ratingSlider.value)) / 5"
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
        
        rewardLabel.snp.makeConstraints { make in
            make.top.equalTo(gigNameLabel.snp.top)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-35)
        }
        
        minimumValueLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingSlider.snp.bottom).offset(5)
            make.left.equalTo(ratingSlider.snp.left)
        }
        
        maximumValueLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingSlider.snp.bottom).offset(5)
            make.right.equalTo(ratingSlider.snp.right)
        }
        
        unsatisfactoryLabel.snp.makeConstraints { make in
            make.top.equalTo(minimumValueLabel.snp.bottom)
            make.left.equalTo(ratingSlider.snp.left)
        }
        
        satisfactoryLabel.snp.makeConstraints { make in
            make.top.equalTo(maximumValueLabel.snp.bottom)
            make.right.equalTo(ratingSlider.snp.right)
        }
        
        submitRatingButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-25)
            make.height.equalTo(60)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(28)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-28)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.bottom.equalTo(ratingSlider.snp.top).offset(-10)
        }
    }
    
    
}
