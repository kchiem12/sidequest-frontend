//
//  AddJobViewController.swift
//  sidequest1
//
//  Created by Jesse Cheng on 11/26/22.
//

import UIKit
import SnapKit

class AddJobViewController: UIViewController {
    
    // Set Up Variables
    var yourGigLabel = UILabel()
    var createPostButton = UIButton()
    var user: User?

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

        title = "YAAKHFLAJKDG"
        
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
//        yourPostCollectionView.dataSource = self

        // Set collection view delegate
        yourPostCollectionView.delegate = self

        // Register collection view
        yourPostCollectionView.register(YourPostCollectionViewCell.self, forCellWithReuseIdentifier: yourPostReuseIdentifier)
        view.addSubview(yourPostCollectionView)

        
        // Set Up Properties
        createPostButton.setTitle("Create post!", for: .normal)
        createPostButton.layer.cornerRadius = 16
        createPostButton.layer.backgroundColor = UIColor(red: 0.25, green: 0.521, blue: 0.521, alpha: 1).cgColor
        createPostButton.addTarget(self, action: #selector(createPost as () -> Void), for: .touchUpInside)
        view.addSubview(createPostButton)
        
        // Set Up Constraints
        createPostButton.snp.makeConstraints{(make) -> Void in
            make.width.equalTo(336)
            make.height.equalTo(60)
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-30)

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
        }
        
    }
}

//extension AddJobViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
//
//
//}

extension AddJobViewController: UICollectionViewDelegate {
    
}
