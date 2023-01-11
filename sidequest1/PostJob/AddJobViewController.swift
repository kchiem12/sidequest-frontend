//
//  AddJobViewController.swift
//  sidequest1
//
//  Created by Jesse Cheng on 11/26/22.
//

import UIKit
import SnapKit

class AddJobViewController: UIViewController {
    
    // MARK: UI Elements
    var yourGigLabel = UILabel()
    var createPostButton = UIButton()
    var user: User

    // MARK: Data
    var postingData: [Job] = []
    var shownPostingData: [Job] = []
    
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Set Up CollectionView Var
    var yourPostCollectionView: UICollectionView!
    let spacing1: CGFloat = 15
    let yourPostReuseIdentifier: String = "yourPostReuseIdentifier"
    
    let navigationImageView: UIImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set top left image as logo
        navigationImageView.image = UIImage(named: "navigation title")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: navigationImageView)
        
        view.backgroundColor = UIColor(red: 0.847, green: 0.876, blue: 0.95, alpha: 1)
        
        // Nav Bar Color
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(rgb: 0x6EBABA)
        navigationItem.standardAppearance = appearance;
        navigationItem.scrollEdgeAppearance = navigationItem.standardAppearance
        
        // Posting Collection View
        // Setup flow layout
        let yourPostingLayout = UICollectionViewFlowLayout()
        yourPostingLayout.minimumLineSpacing = spacing1
        yourPostingLayout.scrollDirection = .vertical

        // Instantiate collection view
        yourPostCollectionView = UICollectionView(frame: .zero, collectionViewLayout: yourPostingLayout)
        yourPostCollectionView.backgroundColor = UIColor(red: 0.847, green: 0.876, blue: 0.95, alpha: 1)

        // Set collection view data source
        yourPostCollectionView.dataSource = self

        // Set collection view delegate
        yourPostCollectionView.delegate = self

        // Register collection view
        yourPostCollectionView.register(YourPostCollectionViewCell.self, forCellWithReuseIdentifier: yourPostReuseIdentifier)
        view.addSubview(yourPostCollectionView)

        getUsersPosts()
        
        // Set Up Properties
        yourGigLabel.text = "Your gig posts"
        yourGigLabel.font = UIFont(name: "Merriweather-Regular", size: 24)
        yourGigLabel.textColor = UIColor(red: 0.25, green: 0.521, blue: 0.521, alpha: 1)
        view.addSubview(yourGigLabel)
        
        createPostButton.setTitle("Create post!", for: .normal)
        createPostButton.titleLabel?.font = UIFont(name: "Merriweather-Regular", size: 24)
        createPostButton.layer.cornerRadius = 16
        createPostButton.layer.backgroundColor = UIColor(red: 0.25, green: 0.521, blue: 0.521, alpha: 1).cgColor
        createPostButton.addTarget(self, action: #selector(createPost as () -> Void), for: .touchUpInside)
        view.addSubview(createPostButton)
        
        // Set Up Constraints
        yourGigLabel.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            make.left.equalTo(view.snp.left).offset(30)
        }
        
        createPostButton.snp.makeConstraints{(make) -> Void in
            make.width.equalTo(336)
            make.height.equalTo(60)
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-30)
        }
    
        yourPostCollectionView.snp.makeConstraints {(make) -> Void in
            make.top.equalTo(yourGigLabel.snp.bottom).offset(17)
            make.left.equalTo(view.snp.left).offset(1)
            make.right.equalTo(view.snp.right).offset(-1)
            make.bottom.equalTo(createPostButton.snp.top).offset(-34)
        }
    }
    
    // Retrieves every job the User has posted
    func getUsersPosts() {
        
        var postsData: [Job] = []
        print("\(user.job_as_poster.count)")
        
        DispatchQueue.main.async {
            for job in self.user.job_as_poster {
                print("\(job.id!)")
                NetworkManager.getSpecificJob(jobID: job.id!) { job in
                    
                    guard let theJob = job else {
                        return
                    }
                    
                    postsData.append(theJob)
                    self.postingData = postsData
                    self.shownPostingData = self.postingData
                    self.yourPostCollectionView.reloadData()
                }
            }
        }
    }
    
    // Presents a view controller to allow a user to create a post
    @objc func createPost() {
        present(PublishJobPresentViewController(delegate: self, user: user), animated: true)
    }

}

extension AddJobViewController: CreatePostDelegate {
    func createPost(userID: Int, title: String, description: String, location: String, date_activity: String, duration: Int, reward: String, category: String, longtitude: Int, latitude: Int, other_notes: String, relevant_skills: String) {
        
        NetworkManager.createPost(userID: user.id, title: title, description: description, location: location, date_activity: date_activity, duration: duration, reward: reward, category: category, longtitude: longtitude, latitude: latitude, other_notes: other_notes, relevant_skills: relevant_skills) { job in
            //TODO: Finish this
            self.shownPostingData = [job] + self.shownPostingData
            self.postingData = self.shownPostingData
            self.yourPostCollectionView.reloadData()
        }
    }
}

extension AddJobViewController: EditPostDelegate {
    func presentEditVC(job: Job) {
        present(EditJobViewController(delegate: self, job: job), animated: true)
    }
    
    func editPost(jobID: Int, title: String, description: String, location: String, date_activity: String, duration: Int, reward: String, category: String, longtitude: Int, latitude: Int, other_notes: String, relevant_skills: String) {
        
        NetworkManager.updateJob(jobId: jobID, title: title, description: description, location: location, date_activity: date_activity, duration: duration, reward: reward, category: category, longtitude: longtitude, latitude: latitude, other_notes: other_notes, relevant_skills: relevant_skills) { completionStatus in
            if (completionStatus) {
                print("Update successful")
                self.getUsersPosts() // Update the collection view
            } else {
                print("Update unsuccessful")
            }
        }
    }
    
    
    func deletePost(jobID: Int, index: Int) {
        
        let archiveAlert = UIAlertController(title: "Archive Post", message: "Post will be removed from public", preferredStyle: UIAlertController.Style.alert)
        
        archiveAlert.addAction(UIAlertAction(title: "Confirm", style: .destructive, handler: { (action: UIAlertAction!) in
            NetworkManager.archiveJob(jobID: jobID) { success in
                if (success) {
                    print("Archive successful")
                    self.postingData.remove(at: index)
                    self.shownPostingData.remove(at: index)
                    self.yourPostCollectionView.reloadData()
                } else {
                    print("Archive unsuccessful")
                }
            }
            archiveAlert.dismiss(animated: true)
        }))
        
        archiveAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("canceled archive")
            archiveAlert.dismiss(animated: true)
        }))
        
        present(archiveAlert, animated: true, completion: nil)
    }
}

extension AddJobViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shownPostingData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: yourPostReuseIdentifier, for: indexPath) as? YourPostCollectionViewCell{
            cell.configure(job: shownPostingData[indexPath.row], delegate: self, index: indexPath.row)
            cell.contentView.backgroundColor = UIColor.white
            cell.contentView.layer.cornerRadius = 16
            return cell
        }
        else {
            return UICollectionViewCell()
        }
    }

}

extension AddJobViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 365, height: 313)
    }
}
