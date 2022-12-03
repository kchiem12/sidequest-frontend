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
    var user: User?

    // MARK: Data
    var postingData: [Job] = []
    var shownPostingData: [Job] = []
    
    init(user: User?) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Set Up CollectionView Var
    var yourPostCollectionView: UICollectionView!
    let spacing1: CGFloat = 15
    let yourPostReuseIdentifier: String = "yourPostReuseIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "SideQuest"
                
        // Nav Bar Color
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 0.431, green: 0.729, blue: 0.729, alpha: 1)
        navigationItem.standardAppearance = appearance;
        navigationItem.scrollEdgeAppearance = navigationItem.standardAppearance
        
        view.backgroundColor = UIColor(red: 0.847, green: 0.876, blue: 0.95, alpha: 1)
        
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

        createDummyData()
        
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
            make.left.equalTo(view.snp.left).offset(15)
            make.right.equalTo(view.snp.right).offset(-15)
            make.bottom.equalTo(createPostButton.snp.top).offset(-34)
        }
    }
    
    func createDummyData() {
        // MARK: Use getAllPosts
        /**
         We want to retrieve data from the server here upon refresh. Make sure to
         1) Sort the posts with `sortPostData`
         2) Update `postData` & `shownPostData` and reload `postTableView`
         */

        NetworkManager.getAllPosts { posts in
            self.postingData = posts
//            self.sortPostData()
            self.shownPostingData = self.postingData
            self.yourPostCollectionView.reloadData()
        }
    }
    
    @objc func createPost() {
        present(PublishJobPresentViewController(delegate: self, user: user!), animated: true)
    }

}

extension AddJobViewController: CreatePostDelegate {
    func createPost(userID: Int, title: String, description: String, location: String, date_activity: String, duration: Int, reward: String, category: String, longtitude: Int, latitude: Int) {
        
        NetworkManager.createPost(userID: user!.id, title: title, description: description, location: location, date_activity: date_activity, duration: duration, reward: reward, category: category, longtitude: longtitude, latitude: latitude) { Job in
            //TODO: Finish this
            self.shownPostingData = [Job] + self.shownPostingData
            
            //let image: UIImageView = UIImageView()
            
//            NetworkManager.uploadJobAsset(jobID: Job.id, base64: (self.user?.assets[0].url)!) { success, ack in
//                if success {
//                    print("success")
//                } else {
//                    print("failed to upload image")
//                }
//            }
            
            self.yourPostCollectionView.reloadData()
        }
        
    }
}

extension AddJobViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shownPostingData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: yourPostReuseIdentifier, for: indexPath) as? YourPostCollectionViewCell{
            cell.configure(job: shownPostingData[indexPath.row])
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
